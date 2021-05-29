
<!-- README.md is generated from README.Rmd. Please edit that file -->

# natmanager

<!-- badges: start -->

[![natmanager](https://img.shields.io/badge/natmanager-Part%20of%20the%20natverse-a241b6)](http://natverse.org/)
[![CRAN](https://img.shields.io/cran/v/natmanager)](https://cran.r-project.org/package=natmanager)
[![GitHub](https://img.shields.io/github/v/release/natverse/natmanager)](https://github.com/natverse/natmanager/releases/)
[![Docs](https://img.shields.io/badge/docs-100%25-brightgreen.svg)](http://natverse.org//natmanager/reference/)
![CRAN
Downloads](http://cranlogs.r-pkg.org/badges/grand-total/natmanager)
[![R-CMD-check](https://github.com/natverse/natmanager/workflows/R-CMD-check/badge.svg)](https://github.com/natverse/natmanager/actions)
<!-- badges: end -->

The goal of natmanager is to streamline installation of packages from
the natverse (NeuroAnatomy Toolbox) suite of R packages for
computational neuroanatomy. See <http://natverse.org/install/> for the
full details.

``` r
install.packages('natmanager')

# install core packages to try out the core natverse
natmanager::install('core')

# Full "batteries included" installation with all packages
# It is recommended to have a GitHub account and personal access token (PAT) for this full
# batteries installation. However if you don't have one, then natmanager's default PAT will be used.
natmanager::install('natverse')

#you can also install non-natverse packages like below, this feature is useful if you want to avoid
#rate limiting issues from github and errors from warnings while installing packages:
natmanager::install(pkgs = 'flyconnectome/hemibrainr')
```
