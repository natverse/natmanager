
<!-- README.md is generated from README.Rmd. Please edit that file -->

# natmanager

<!-- badges: start -->

[![natmanager](https://img.shields.io/badge/natmanager-Part%20of%20the%20natverse-a241b6)](https://natverse.github.io)
[![Docs](https://img.shields.io/badge/docs-100%25-brightgreen.svg)](https://natverse.github.io/natmanager/reference/)
[![Travis build
status](https://travis-ci.org/natverse/natmanager.svg?branch=master)](https://travis-ci.org/natverse/natmanager)
<!-- badges: end -->

The goal of natmanager is to handle the installation of all packages
inside the natverse repository.

# Prerequisite

To install this package you need to have `R` and `R-studio` installed.
The detailed instructions per operating system are given below.

### Linux

1.  Install `r`, in terminal type below:

<!-- end list -->

``` bash
sudo apt-get install libopenblas-base r-base
```

2.  Install `R-studio`, in terminal type below:

<!-- end list -->

``` bash
sudo apt-get install gdebi
cd ~/Downloads
wget https://download1.rstudio.org/rstudio-xenial-1.1.419-amd64.deb
sudo gdebi rstudio-xenial-1.1.419-amd64.deb
```

3.  Start `R-studio`, in terminal type below:

<!-- end list -->

``` bash
rstudio
```

### Mac OS X

1.  Install `r` from here:
    [r-installation](http://cran.cnr.berkeley.edu/bin/macosx/)

2.  Install `R-studio`, from here:
    [R-studio-installation](https://rstudio.com/products/rstudio/download/#download)

3.  Start `R-studio` from Launchpad

### Windows

1.  Install `r` from here:
    [r-installation](http://cran.cnr.berkeley.edu/bin/windows/base/)

2.  Install `R-studio`, for Windows from here:
    [R-studio-installation](https://rstudio.com/products/rstudio/download/#download)

3.  Start `R-studio` from Programs menu

# Installation

You can install the released version of natmanager from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("natmanager")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("natverse/natmanager")
```

# Usage

Once installed, you can install packages inside the natverse repository
as follows:

``` r
library('natmanager')
install('natverse')
```

You can also look at all the repos available in the natverse
organization as follows:

``` r
natmanager::list_repo()
#>  [1] "nat"                "flycircuit"         "nat.flybrains"     
#>  [4] "nat.examples"       "nat.nblast"         "nat.templatebrains"
#>  [7] "rcatmaid"           "elmr"               "mouselightr"       
#> [10] "nat.jrcbrains"      "nat.h5reg"          "drvid"             
#> [13] "neuprintr"          "neuromorphr"        "natverse"          
#> [16] "natverse_hugo"      "natverse.github.io" "insectbrainr"      
#> [19] "nat.devtools"       "fishatlas"          "natmanager"
```
