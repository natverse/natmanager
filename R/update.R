#'
#' This will update the `natmanager` package itself.
#' @param source Location to look for updating the package from, can be 'GITHUB' or 'CRAN'.
#' @param ... extra arguments to pass to \code{\link[remotes]{install_github}} or \code{\link[remotes]{install_cran}}.
#' @export
#' @examples
#' \dontrun{
#' library('natmanager')
#' update()
#' }
update <- function(source=c('GITHUB','CRAN'), ...) {

  source <- match.arg(source)

  if(source == 'CRAN'){
    remotes::install_cran('natmanager', ...)
  }else{
    remotes::install_github('natverse/natmanager', ...)
    }

}
