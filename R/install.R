#' Install packages inside the natverse repository.
#'
#' This will check to see if the GITHUB_PAT is set and will provide instructions to the user to set it
#' Further, if the GITHUB_PAT is set it will start installing the dependencies of the `natverse` package.
#' @param pkgname Package name inside the `natverse` repository.
#' @param dependencies Which dependencies you want to install see \code{\link[remotes]{install_github}}.
#' @param ... extra arguments to pass to \code{\link[remotes]{install_github}}.
#' @importFrom utils install.packages
#' @export
#' @examples
#' \dontrun{
#' library('NatManager')
#' install('natverse')
#' }
install <- function(pkgname,dependencies=TRUE, ...) {

  if(!requireNamespace('remotes', quietly=TRUE)) utils::install.packages('remotes')
  if(!requireNamespace('usethis', quietly=TRUE)) utils::install.packages('usethis')
  if(!nzchar(Sys.getenv('GITHUB_PAT'))) {
    message('Attempting to set GITHUB_PAT')
    usethis::browse_github_token()
    message('Run the install function again after following above instructions')
  } else{
    remotes::install_github(paste0("natverse/",pkgname),auth_token = Sys.getenv('GITHUB_PAT'), dependencies=dependencies, ...)
  }
}
