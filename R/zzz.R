.packageinfo <- new.env()

.onAttach <- function(libname, pkgname) {
  .packageinfo$pkgname=pkgname
  invisible()
}

#' @importFrom usethis ui_todo ui_code ui_code_block ui_oops ui_yeah ui_done
#'   ui_stop
#'
#' @description \code{check_pat} can be used to check if you have a GITHUB_PAT
#'   set and will advise on how to do this if necessary.
#' @param create Whether to help you create a personal GITHUB_PAT if you do not
#'   have one set. When \code{create=FALSE} a default PAT will be used if you
#'   have not set your own. This could cause trouble if other people are using
#'   the same PAT.
#' @export
#' @return \code{check_pat} returns the PAT invisibly or errors out if
#'   \code{create=TRUE} and none can be set.
#' @rdname install
#' @examples
#' \dontrun{
#' # Check status of GitHub PAT and create one if required
#' natmanager::check_pat(create=TRUE)
#' # Check status of GitHub PAT and use default if no personal one available
#' natmanager::check_pat(create=FALSE)
#' }
check_pat <- function(create=TRUE) {
  pat=gh::gh_token()
  if (isFALSE(nzchar(pat))  && isFALSE(create)) {
    pat <- paste0("ghp_",
                  "k4WlWl4B3trj1",
                  "iZqir2DKdzCm9",
                  "7zyu2wCQge")
    ui_todo(c(
      "Using natmanager's default GitHub access token (PAT) to install packages.",
      "If you see error messages relating to GitHub rate limiting then use:",
      "{ui_code('natmanager::check_pat()')}","to create your own."))
  } else if (isFALSE(nzchar(pat))) {
    if (interactive()) {
      ui_oops("You should have a GitHub account and PAT (Personal Access Token) to install the full natverse!")
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
        usethis::create_github_token(description = "R:NATVERSE:GITHUB_PAT")
      } else {
        ui_todo("When ready, get your GitHub PAT with {ui_code('usethis::create_github_token()')}")
      }
      ui_stop("No GITHUB_PAT set")
    } else {
      stop("Please run natmanager::install() in an interactive R session!\n",
           "See http://natverse.org/install/ for details!")
    }
  } else{
    # nothing to do. Only put message if we were considering making a PAT
    if(create)
      ui_done("You have a personal GITHUB_PAT set.")
  }
  invisible(pat)
}
