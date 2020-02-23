#' Update the `natmanager` package itself.
#'
#' @param source Location from which to obtain a newer version of natmanager.
#'   Defaults to GITHUB since this may well have a newer version than the CRAN
#'   packgae repository.
#' @param ... extra arguments to pass to \code{\link[remotes]{install_github}}
#'   or \code{\link[remotes]{install_cran}}.
#' @param dependencies.upgrade Whether to ask to install dependencies of
#'   natmanager. See the \code{upgrade} argument of
#'   \code{\link[remotes]{install_github}} for details.
#' @export
#' @seealso \code{\link{install}}
#' @examples
#' \dontrun{
#' natmanager::selfupdate()
#' }
selfupdate <- function(source = c('GITHUB', 'CRAN'),
                       dependencies.upgrade='never', ...) {
  source <- match.arg(source)

  with_envvars({
    if (source == 'CRAN') {
      remotes::install_cran('natmanager', ...)
    } else {
      remotes::install_github('natverse/natmanager',
                              upgrade=dependencies.upgrade, ...)
    }
  })
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
      paste0("There is a newer version of natmanager. Would you like to update\n",
      " (recommended!)"),
      default = TRUE
    )
    if (isTRUE(res))
      selfupdate(...)
  }
}
