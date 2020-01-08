#' Install packages inside the natverse repository.
#'
#' This will check to see if the GITHUB_PAT is set and will provide instructions to the user to set it
#' Further, if the GITHUB_PAT is set it will start installing the dependencies of the `natverse` package.
#' @param pkgname Package name inside the `natverse` repository.
#' @param ... extra arguments to pass to \code{\link[remotes]{install_github}}.
#' @importFrom utils install.packages
#' @export
#' @examples
#' \dontrun{
#' install()
#' }
install <- function(pkgname,...) {

  if(!requireNamespace('remotes', quietly=TRUE)) utils::install.packages('remotes')
  if(!requireNamespace('usethis', quietly=TRUE)) utils::install.packages('usethis')
  if(!nzchar(Sys.getenv('GITHUB_PAT'))) {
    message('Attempting to set GITHUB_PAT')
    usethis::browse_github_token()
  } else{
    remotes::install_github(paste0("natverse/",pkgname),auth_token = Sys.getenv('GITHUB_PAT'), dependencies=TRUE)
  }
}
