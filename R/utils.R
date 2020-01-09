#' List all the repos inside a particular ogranization inside the natverse repository.
#'
#' This will list all the repositories inside the `natverse` organization.
#' @param orgname Name of the organization in github to list repositories from.
#' @return List of repositories
#' @export
#' @examples
#' \dontrun{
#' library('NatManager')
#' list_repo()
#' }

list_repo <- function(orgname = 'natverse') {
  repos <- gh::gh(paste0("/orgs/",orgname,"/repos"), type = "public")
  vapply(repos, "[[", "", "name")
}
