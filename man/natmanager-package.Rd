% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/natmanager-package.R
\docType{package}
\name{natmanager-package}
\alias{natmanager}
\alias{natmanager-package}
\title{natmanager: Install the 'Natverse' Packages from Scratch}
\description{
Provides streamlined installation for packages from the 'natverse', a suite of R packages for computational neuroanatomy built on top of the 'nat' 'NeuroAnatomy Toolbox' package. Installation of the complete 'natverse' suite requires a 'GitHub' user account and personal access token 'GITHUB_PAT'. 'natmanager' will help the end user set this up if necessary.
}
\examples{
\dontrun{
# install core packages to try out the core natverse
if(is.interactive()) {
natmanager::install('core')
}
# Full "batteries included" installation with all packages
# You need a GitHub account and personal access token (PAT) for this
if(is.interactive()) {
natmanager::install('natverse')
}
}
}
\seealso{
\code{\link{install}}
}
\author{
\strong{Maintainer}: Gregory Jefferis \email{jefferis@gmail.com} (\href{https://orcid.org/0000-0002-0587-9355}{ORCID})

Authors:
\itemize{
  \item Sridhar Jagannathan \email{j.sridharrajan@gmail.com} (\href{https://orcid.org/0000-0002-2078-1145}{ORCID})
}

}
\keyword{internal}
