library(testthat)
library(natmanager)

.libPaths( c( "/home/travis/R/Library" , .libPaths()))

library(lattice)

test_check("natmanager")
