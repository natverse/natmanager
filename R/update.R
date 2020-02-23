#' Update the `natmanager` package itself.
#'
#' @param source Location from which to obtain package updates. Defaults to
#'   GITHUB since this may well have a newer version than the CRAN packgae
#'   repository.
#' @param ... extra arguments to pass to \code{\link[remotes]{install_github}}
#'   or \code{\link[remotes]{install_cran}}.
#' @export
#' @seealso \code{\link{install}}
#' @examples
#' \dontrun{
#' library('natmanager')
#' update()
#' }
update <- function(source = c('GITHUB', 'CRAN'), ...) {
  source <- match.arg(source)

  if (source == 'CRAN') {
    remotes::install_cran('natmanager', ...)
  } else {
    remotes::install_github('natverse/natmanager', ...)
  }
}
