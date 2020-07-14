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

  #Step:1, Check version of R..
  if(grepl("3.5", getRversion())) { #check if version is 3.5.x
    warning(paste0("Update your R version, it is recommended to use > 3.5 ",
                   'and your current version is: ', getRversion()))
  }else if(getRversion() < package_version("3.5.0")){
    stop(paste0("Update your R version, it is recommended to use > 3.5 ",
                'and your current version is: ', getRversion()))
  }

  #Step:2, Check specific softwares that are prerequisites..
  if(isTRUE(.Platform$OS.type == "windows")) {
    return(TRUE)
  }
  if(grepl("^darwin", R.version$os)) {
    if(!have_xquartz()){
      usethis::ui_todo(paste("Please download and install Xquartz from",
                       "https://www.xquartz.org!\nThis is a system requirement",
                       "and is needed for 3D display of neurons."))
      return(FALSE)
    }
    return(TRUE)
  }
  if(grepl("linux-gnu", R.version$os)) {
    return(TRUE)
  }
  if(grepl("solaris", R.version$os)) {
    return(TRUE)
  }
  warning("Unrecognised platform! Unable to check system requirements.")
  return(TRUE)
}
