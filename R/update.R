#' Update the `natmanager` package itself.
#'
#' @param source Location from which to obtain a newer version of natmanager.
#'   Defaults to GITHUB since this may well have a newer version than the CRAN
#'   packgae repository.
#' @param ... extra arguments to pass to \code{\link[remotes]{install_github}}
#'   or \code{\link[remotes]{install_cran}}.
#'   @param dependencies.upgrade See
#' @export
#' @seealso \code{\link{install}}
#' @examples
#' \dontrun{
#' natmanager::selfupdate()
#' }
selfupdate <- function(source = c('GITHUB', 'CRAN'),
                       dependencies.upgrade='never', ...) {
  source <- match.arg(source)

  with_envvars({
    if (source == 'CRAN') {
      remotes::install_cran('natmanager', ...)
    } else {
      remotes::install_github('natverse/natmanager',
                              upgrade=dependencies.upgrade, ...)
    }
  })
}
