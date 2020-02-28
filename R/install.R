#' Install natverse packages from GitHub
#'
#' @description \code{install} allows you to install one of two collections of
#'   nat packages
#'
#'   \itemize{
#'
#'   \item \code{core} a minimal install that can use to get started with nat
#'   and already solve many problems (the default)
#'
#'   \item \code{natverse} a powerful "batteries included" distribution with all
#'   mature packages in the natverse.
#'
#'   }
#'
#'   Since the \code{natverse} option will install many packages from GitHub,
#'   you need to have a GitHub account and personal access token (GITHUB_PAT).
#'   Install will check to see if you have a \code{GITHUB_PAT} already and, if
#'   not, walk you through the steps of setting one up.
#'
#' @param collection The collection of natverse packages that you would like to
#'   install. The current options are \code{core}, the default, or
#'   \code{natverse}. See Description for more information.
#' @param dependencies Which dependencies you want to install see
#'   \code{\link[remotes]{install_github}}.
#' @param ... extra arguments to pass to \code{\link[remotes]{install_github}}.
#' @importFrom utils install.packages
#' @inheritParams selfupdate
#' @export
#' @examples
#' \dontrun{
#' # install core packages to try out the core natverse
#' natmanager::install('core')
#'
#' # Full "batteries included" installation with all packages
#' natmanager::install('natverse')
#' }
#' @importFrom usethis ui_info
install <- function(collection = c('core', 'natverse'), dependencies = TRUE,
                    upgrade.dependencies='always', ...) {

  collection=match.arg(collection)

  pkgs <- if(collection=="core") {
    c("nat", "nat.nblast", "nat.templatebrains")
  } else {
    "natverse"
  }
  repos = paste0("natverse/", pkgs)

  # Update if necessary
  smartselfupdate()

  # We should be able to install core packages without the pat
  if(collection!='core')
    check_pat()

  with_envvars(remotes::install_github(
    repos,
    dependencies = dependencies,
    upgrade = upgrade.dependencies,
    ...
  ))

  if(collection=='core') {
    ui_todo("To install the full natverse in future do {ui_code('natmanager::install(\"natverse\")')}")
    ui_info("Load the core nat package with {ui_code('library(nat)')}")
  } else {
    ui_info("Load the full natverse with {ui_code('library(natverse)')}")
  }
}

with_envvars <- function(expr) {
  #Set the option for install, such that warnings from remotes package are not converted to errors..
  #For details see here: https://github.com/r-lib/remotes/issues/403
  old=Sys.getenv("R_REMOTES_NO_ERRORS_FROM_WARNINGS")
  Sys.setenv("R_REMOTES_NO_ERRORS_FROM_WARNINGS" = TRUE)
  on.exit(Sys.setenv("R_REMOTES_NO_ERRORS_FROM_WARNINGS" = old))
  force(expr)
}
