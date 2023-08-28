#' List all the repos inside a particular GitHub organisation
#'
#' @description by default this will list all the repositories inside the
#'   `natverse` organization.
#'
#' @param orgname Name of the GitHub organization
#' @return Character vector of repository names
#' @export
#' @examples
#' \dontrun{
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

  #Step:1, Check version of R ...
  rversion <- getRversion()
  minversion = '3.5.0'
  recommended = '4.0.2'
  if(rversion<minversion) {
    stop(
      paste0("Please update your R version. The natverse is designed for R >= ",
             minversion,
             ' and your current version is: ', rversion))
  } else if(rversion<recommended) {
    warning(paste0("We recommend updating your R version to >= ", recommended,
                   ' but your current version is: ', rversion))
  }

  #Step:2, Check specific software that are prerequisites ..
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
