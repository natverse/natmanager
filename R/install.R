#' Install natverse packages from GitHub
#'
#' @description \code{install} allows you to install one of two collections of
#'   nat packages
#'
#'   \itemize{
#'
#'   \item \code{core} a minimal install that can help users to get started with
#'   nat and already solve many problems (the default)
#'
#'   \item \code{natverse} a powerful "batteries included" distribution with all
#'   mature packages in the natverse.
#'
#'   }
#'
#'   Since the \code{natverse} option will install many packages from GitHub,
#'   you need to have a GitHub account and personal access token (GITHUB_PAT).
#'   Install will check to see if you have a \code{GITHUB_PAT} already and, if
#'   not, walk you through the steps of setting one up. A fall-back PAT is built
#'   into the package but we strongly recommend that you sign up to GitHub and
#'   get your own if you start using the natverse regularly.
#'
#' @param collection The collection of natverse packages that you would like to
#'   install. The current options are \code{core}, the default, or
#'   \code{natverse}. See Description for more information.
#' @param pkgs A character vector of package names specifying natverse packages
#'   to install. When present overrides the \code{collection} argument.
#' @param dependencies Which dependencies you want to install see
#'   \code{\link[remotes]{install_github}}.
#' @param ... extra arguments to pass to \code{\link[remotes]{install_github}}.
#' @importFrom utils install.packages
#' @importFrom usethis ui_info
#' @inheritParams selfupdate
#' @export
#' @examples
#' \dontrun{
#' # install core packages to try out the core natverse
#' natmanager::install('core')
#'
#' # Full "batteries included" installation with all packages
#' natmanager::install('natverse')
#'
#' # Install a specific natverse package
#' natmanager::install(pkgs='nat.jrcbrains')
#' }
install <- function(collection = c('core', 'natverse'), pkgs=NULL,
                    dependencies = TRUE,
                    upgrade.dependencies='always', ...) {

  collection=match.arg(collection)
  if(is.null(pkgs)) {
    pkgs <- if(collection=="core")
      c("nat", "nat.nblast", "nat.templatebrains")
    else
      "natverse"
  } else {
    collection=NULL
  }
  repos = paste0("natverse/", pkgs)

  # use personal PAT or bundled one if that fails
  envvars = c(
    GITHUB_PAT = check_pat(create = FALSE),
    R_REMOTES_NO_ERRORS_FROM_WARNINGS = TRUE
  )
  # can help with permissions errors when updating loaded libraries
  if(isTRUE(.Platform$OS.type == "windows"))
    envvars = c(envvars, R_REMOTES_STANDALONE = TRUE)
  withr::local_envvar(envvars)
  # only use source packages if essential
  withr::local_options(list(install.packages.compile.from.source='never'))
  # withr::local_options(list(install.packages.check.source='no'))

  # Update if necessary and stop the rest of the update process if we had to
  if(smartselfupdate()) return(invisible(NULL))

  res <- remotes::install_github(
    repos,
    dependencies = dependencies,
    upgrade = upgrade.dependencies,
    ...
  )

  if(isTRUE(collection=='core')) {
    ui_info("Load the core nat package with {ui_code('library(nat)')}")
    ui_todo("To install the full natverse in future do {ui_code('natmanager::install(\"natverse\")')}")
  } else if(isTRUE(collection=='natverse')){
    ui_info("Load the full natverse with {ui_code('library(natverse)')}")
  }

  invisible(res)
}
