#' List all the repos inside a particular GitHub organisation
#'
#' @description by default this will list all the repositories inside the
#'   `natverse` organization.
#'
#' @param orgname Name of the GitHub organization
#' @return Character vector of repository names
#' @export
#' @examples
#' \donttest{
#' natverse::list_repo()
#' }
list_repo <- function(orgname = 'natverse') {
  repos <- gh::gh(paste0("/orgs/",orgname,"/repos"), type = "public")
  vapply(repos, "[[", "", "name")
}
