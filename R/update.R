#' Update the `natmanager` package itself.
#'
#' @param source Location from which to obtain a newer version of natmanager.
#'   Defaults to GITHUB since this may well have a newer version than the CRAN
#'   package repository.
#' @param force Force self update even if there doesn't seem to be an update
#'   (default \code{FALSE})
#' @inheritParams install
#' @return Logical indicating whether an update was required (invisibly).
#' @importFrom utils browseURL packageVersion
#' @export
#' @seealso \code{\link{install}}
#' @examples
#' \dontrun{
#' natmanager::selfupdate()
#' }
selfupdate <- function(source = c('GITHUB', 'CRAN'),
                       upgrade.dependencies=TRUE, force=FALSE,
                       method=c("pak","remotes"), ...) {
  source <- match.arg(source)

  oldVersion=utils::packageVersion('natmanager')

  # use personal PAT or bundled one if that fails
  withr::local_envvar(c(GITHUB_PAT=check_pat(create = FALSE),
                        R_REMOTES_NO_ERRORS_FROM_WARNINGS=TRUE))
  # only use source packages if essential
  withr::local_options(list(install.packages.compile.from.source='never'))

  method=match.arg(method)
  pkgspec=ifelse(source=='CRAN', "natmanager", "natverse/natmanager")
  if(method=='pak') {
    if(isTRUE(force))
      warning("Ignoring force=T. To force pak to reinstall an up-to-date package",
              "you must first delete it with:\n",
              "`remove.packages()`", immediate.=TRUE)
pak::pkg_install(pkgspec, upgrade=upgrade.dependencies, ...)
  }
  else if (source == 'CRAN') {
      remotes::install_cran(pkgspec, ...)
  } else {
    remotes::install_github(pkgspec,
                            upgrade=upgrade.dependencies, force=force, ...)
  }

  newVersion=utils::packageVersion('natmanager')

  if(isTRUE(newVersion>oldVersion) || isTRUE(force)) {
    if(isTRUE(Sys.getenv("RSTUDIO")=="1")  &&
       isTRUE(requireNamespace('rstudioapi', quietly=TRUE))) {
      canrestart=utils::askYesNo("Can I restart R?")
      if (isTRUE(canrestart)) {
        # check if selfupdate was called directly
        toplevelcall=is.null(sys.call(-1))
        topcall=""
        if(!toplevelcall) {
          # get the top level call
          topcall=deparse(sys.calls()[[1]])
          # add natmanager:: prefix so we can run it without loading package
          topcall=sub("^install\\(", "natmanager::install(", topcall)
          # clear topcall if it doesn't look like a plain install command
          if(isFALSE(grepl("^natmanager::install", topcall))) topcall=""
        }
        if(nzchar(topcall)) {
          message("Thank you! I will run ", topcall, " after restarting!")
        } else {
          message("Thank you! You can run natmanager::install() after restarting!")
        }
        rstudioapi::restartSession(command = topcall)
        # I think we need to stop here to prevent callees from continuing to go
        # about their business because the session restart does not stop R immediately
        message("Waiting for restart ...")
      } else{
        message("OK! But you must restart R before running natmanager::install() again!")
      }
    } else {
      message("You must restart R before running natmanager::install() again!")
    }
    # let callee know we had to update
    invisible(TRUE)
  }
  invisible(FALSE)
}

github_version <- function(repo='natverse/natmanager') {
  tryCatch({
    u=sprintf('https://raw.githubusercontent.com/%s/master/DESCRIPTION', repo)
    con <- curl::curl(u)
    on.exit(close(con))
    ver.str=read.dcf(con, fields = 'Version')
    package_version(ver.str)
  }, error=function(e) NA)
}

github_newer <- function() {
  remote=github_version('natverse/natmanager')
  if(is.na(remote)) return(NA)
  local=utils::packageVersion('natmanager')
  remote>local
}

smartselfupdate <- function(...) {
  if (isTRUE(github_newer()) && interactive()) {
    res = utils::askYesNo(
      paste0("There is a newer version of natmanager. Would you like to update",
      " (recommended!)"),
      default = TRUE
    )
    if (isTRUE(res)) selfupdate(...) else FALSE
  } else FALSE
}
