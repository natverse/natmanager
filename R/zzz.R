.onLoad <- function(libname, pkgname) {
  #just check if the github personal access token is set on loading the package,
  #if not prompt the user to do this before you engage in anything..

  if (!nzchar(Sys.getenv('GITHUB_PAT'))) {
    if (interactive()) {
      natmessage(status = 'Unset', pkgname)
      usethis::browse_github_token()
    } else {
      natmessage(status = 'Prompt', pkgname)
    }

  } else{
    natmessage(status = 'Set', pkgname)
  }

  #Set the option for install, such that warnings from remotes package are not converted to errors..
  #For details see here: https://github.com/r-lib/remotes/issues/403

  Sys.setenv("R_REMOTES_NO_ERRORS_FROM_WARNINGS" = TRUE)
}


natmessage <- function(status, pkgname) {
  if (status == 'Unset') {
    packageStartupMessage(paste0('Attempting to set GITHUB_PAT before using: ', pkgname))
  } else if (status == 'Set') {
    #packageStartupMessage(paste0('Using already set GITHUB_PAT for: ',pkgname))
  } else if (status == 'Prompt') {
    packageStartupMessage(paste0('Start using R interactively to set GITHUB_PAT for: ', pkgname))
  }
}
