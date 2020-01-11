
liblocs <- .libPaths()[1]

test_that("installation works", {

  #Run tests on travis only if the GITHUB_PAT is set
  if (!nzchar(Sys.getenv('GITHUB_PAT'))) {
    skip("Skipping as Github PAT is not set")
  }
  
  r = getOption("repos")
  r["CRAN"] = "https://cloud.r-project.org"
  options(repos = r)

  pkgname <- 'nat'

  if (requireNamespace(pkgname, lib.loc = liblocs, quietly=TRUE)){
    remove.packages(pkgname, lib = liblocs)
  }
  
  cat('\n--Session Info start--\n')
  cat(sessionInfo())
  cat('\n--Session Info end--\n')
  
  natmanager::install(pkgname, repos = c(CRAN = "https://cran.rstudio.com"), dependencies = TRUE, lib = liblocs)
  expect_equal(requireNamespace(pkgname, lib.loc = liblocs, quietly=TRUE),TRUE)

})


test_that("list all natverse repos ", {

  #Run tests on travis only if the GITHUB_PAT is set
  if (!nzchar(Sys.getenv('GITHUB_PAT'))) {
    skip("Skipping as Github PAT is not set")
  }

  pckgs <- natmanager::list_repo()
  expect_is(pckgs, 'character')
})
