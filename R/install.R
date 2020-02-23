#' Install packages from the natverse GitHub repository.
#'
#' This will check to see if the GITHUB_PAT is set and will provide instructions
#' to the user to set it. Further if the GITHUB_PAT is set, it will start
#' installing the dependencies of the `natverse` package.
#' @param pkgname Package name inside the `natverse` repository.
#' @param dependencies Which dependencies you want to install see
#'   \code{\link[remotes]{install_github}}.
#' @param ... extra arguments to pass to \code{\link[remotes]{install_github}}.
#' @importFrom utils install.packages
#' @export
#' @examples
#' \dontrun{
#' library('natmanager')
#' install('natverse')
#' }
install <- function(pkgname = 'natverse', dependencies = TRUE, ...) {
  with_envvars(remotes::install_github(
    paste0("natverse/", pkgname),
    auth_token = Sys.getenv('GITHUB_PAT'),
    dependencies = dependencies,
    ...
  ))
}

with_envvars <- function(expr) {
  #Set the option for install, such that warnings from remotes package are not converted to errors..
  #For details see here: https://github.com/r-lib/remotes/issues/403
  old=Sys.getenv("R_REMOTES_NO_ERRORS_FROM_WARNINGS")
  Sys.setenv("R_REMOTES_NO_ERRORS_FROM_WARNINGS" = TRUE)
  on.exit(Sys.setenv("R_REMOTES_NO_ERRORS_FROM_WARNINGS" = old))
  force(expr)
}
