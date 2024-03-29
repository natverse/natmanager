% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/update.R
\name{selfupdate}
\alias{selfupdate}
\title{Update the `natmanager` package itself.}
\usage{
selfupdate(
  source = c("GITHUB", "CRAN"),
  upgrade.dependencies = TRUE,
  force = FALSE,
  method = c("pak", "remotes"),
  ...
)
}
\arguments{
\item{source}{Location from which to obtain a newer version of natmanager.
Defaults to GITHUB since this may well have a newer version than the CRAN
package repository.}

\item{upgrade.dependencies}{Whether to upgrade dependencies of requested
packages See the \code{upgrade} argument of
\code{pak::\link[pak]{pkg_install}} or
\code{\link[remotes]{install_github}} for details. The default value
(\code{FALSE}) will do the minimum amount to enable you to install the
package(s) you have requested. In contrast \code{TRUE} will go ahead and
upgrade all dependencies to the latest version; pak will potentially
install source packages to do this.}

\item{force}{Force self update even if there doesn't seem to be an update
(default \code{FALSE})}

\item{method}{Whether to use the \code{\link{pak}} (now the default) or
\code{\link[remotes]{install_github}} package for installation.}

\item{...}{extra arguments to pass to \code{pak::\link[pak]{pkg_install}} or
\code{remotes::\link[remotes]{install_github}}.}
}
\value{
Logical indicating whether an update was required (invisibly).
}
\description{
Update the `natmanager` package itself.
}
\examples{
\dontrun{
natmanager::selfupdate()
}
}
\seealso{
\code{\link{install}}
}
