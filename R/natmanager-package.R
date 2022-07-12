#' @seealso \code{\link{install}}
#' @examples
#' \dontrun{
#' # install core packages to try out the core natverse
#' user_input <- readline("Would you like to run examples with install packages? (y/n)  ")
#' if(user_input != 'y') stop('Exiting examples')
#' natmanager::install('core')
#'
#' # Full "batteries included" installation with all packages
#' # You need a GitHub account and personal access token (PAT) for this
#' user_input <- readline("Would you like to run examples with install packages? (y/n)  ")
#' if(user_input != 'y') stop('Exiting examples')
#' natmanager::install('natverse')
#' }
#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL
