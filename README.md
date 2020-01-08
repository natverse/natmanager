
<!-- README.md is generated from README.Rmd. Please edit that file -->

# NatManager

<!-- badges: start -->

[![NatManager](https://img.shields.io/badge/natverse-Part%20of%20the%20natverse-a241b6)](https://natverse.github.io)
[![Docs](https://img.shields.io/badge/docs-100%25-brightgreen.svg)](https://natverse.github.io/natverse/reference/)
[![Travis build
status](https://travis-ci.org/natverse/natverse.svg?branch=master)](https://travis-ci.org/natverse/natverse)
<!-- badges: end -->

The goal of NatManager is to handle the installation of all packages
inside the natverse repository.

## Installation

You can install the released version of NatManager from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("NatManager")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("natverse/NatManager")
```

Once installed, you can install packages inside the natverse repository
as follows:

``` r
NatManager::install('natverse')
```
