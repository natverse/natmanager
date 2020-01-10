r = getOption("repos")
r["CRAN"] = "http://cran.us.r-project.org"
options(repos = r)

test_that("installation works", {

  #Run tests on travis only if the GITHUB_PAT is set
  if (!nzchar(Sys.getenv('GITHUB_PAT'))) {
    skip("Skipping as Github PAT is not set")
  }

  if (requireNamespace('fishatlas', quietly=TRUE)){
    remove.packages('fishatlas', lib = .libPaths())
  }

  natmanager::install('fishatlas', dependencies = TRUE)
  expect_equal(requireNamespace('fishatlas', quietly=TRUE),TRUE)

})


test_that("list all natverse repos ", {

  #Run tests on travis only if the GITHUB_PAT is set
  if (!nzchar(Sys.getenv('GITHUB_PAT'))) {
    skip("Skipping as Github PAT is not set")
  }

  pckgs <- natmanager::list_repo()
  expect_is(pckgs, 'character')
})
