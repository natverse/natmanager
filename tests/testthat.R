library(testthat)
library(natmanager)

.libPaths( c( "/home/travis/R/Library" , .libPaths()))

test_check("natmanager",stop_on_failure = FALSE)
