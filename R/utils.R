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
#' natmanager::list_repo()
#' }
list_repo <- function(orgname = 'natverse') {
  repos <- gh::gh(paste0("/orgs/",orgname,"/repos"), type = "public")
  vapply(repos, "[[", "", "name")
}

have_xquartz <- function() {
  isTRUE(nzchar(Sys.which('Xquartz')))
}

system_requirements_ok <- function() {
  if(isTRUE(.Platform$OS.type == "windows")) {
    return(TRUE)
  }
  sysname=Sys.info()["sysname"]
  if(isTRUE(sysname=='Darwin')) {
    if(!have_xquartz()){
      usethis::ui_todo(paste("Please download and install Xquartz from",
                       "https://www.xquartz.org!\nThis is a system requirement",
                       "and is needed for 3D display of neurons."))
      return(FALSE)
    }
  }
  return(TRUE)
}
