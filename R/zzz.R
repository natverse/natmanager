.packageinfo <- new.env()

.onAttach <- function(libname, pkgname) {
  .packageinfo$pkgname=pkgname
  invisible()
}

#' @importFrom usethis ui_todo ui_code ui_oops ui_yeah ui_done ui_stop
#'
#' @description \code{check_pat} can be used to check if you have a GITHUB_PAT
#'   set and will advise on how to do this if necessary.
#' @export
#' @rdname install
#' @examples
#' \dontrun{
#' # Check status of GitHub PAT
#' check_pat()
#' }
check_pat <- function() {
  pat=usethis::github_token()
  if (isFALSE(nzchar(pat))) {
    if (interactive()) {
      ui_oops("You must have a GitHub account and PAT (Personal Access Token) to install the full natverse!")
      ui_todo("Please read http://natverse.org/install/ for details!")
      message("")
      res=ui_yeah("Shall I open the help page for you?")
      if(isTRUE(res)) {
        browseURL("http://natverse.org/install")
      } else {
        ui_todo("OK. But please do read http://natverse.org/install/ for details!")
      }
      message("")
      res=ui_yeah("Would you like to create a GitHub PAT (Personal Access Token) now?")
      if(isTRUE(res)) {
        usethis::browse_github_pat(description = "R:NATVERSE:GITHUB_PAT")
      } else {
        ui_todo("When ready, get your GitHub PAT with {ui_code('usethis::browse_github_token()')}")
      }
      ui_stop("No GITHUB_PAT set")
    } else {
      stop("Please run natmanager::install() in an interactive R session!\n",
           "See http://natverse.org/install/ for details!")
    }
  } else{
    # nothing to do right now
    ui_done("GITHUB_PAT is set.")
    invisible(TRUE)
  }
}
