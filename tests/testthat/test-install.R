liblocs <- "/home/travis/R/Library"

r = getOption("repos")
r["CRAN"] = "https://cloud.r-project.org"
options(repos = r)

test_that("installation works", {

  #Run tests on travis only if the GITHUB_PAT is set
  if (!nzchar(Sys.getenv('GITHUB_PAT'))) {
    skip("Skipping as Github PAT is not set")
  }

  # This test requires installation and hence only run on travis..
  skip_on_cran()

  if (!nzchar(Sys.getenv('TRAVIS'))){
    skip("Skipping as testcase will only be executed on travis")
  }


  pkgname <- 'nat.templatebrains'

  if (requireNamespace(pkgname, lib.loc = liblocs, quietly=TRUE)){
    remove.packages(pkgname, lib = liblocs)
  }

  natmanager::install(collection = 'core', dependencies = c("Depends", "Imports"),
                      upgrade.dependencies = FALSE, lib = liblocs)
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
