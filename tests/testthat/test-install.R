liblocs <- "/home/runner/work/_temp/Library"

r = getOption("repos")
r["CRAN"] = "https://cloud.r-project.org"
options(repos = r)

test_that("installation works", {


  # This test requires installation and hence only run on github actions..
  skip_on_cran()

  if (!nzchar(Sys.getenv('GITHUB_ACTIONS'))){
    skip("Skipping as testcase will only be executed on github actions")
  }


  pkgname <- 'nat.templatebrains'

  if (requireNamespace(pkgname, lib.loc = liblocs, quietly=TRUE)){
    remove.packages(pkgname, lib = liblocs)
  }

  #unset the pat, as the core installation can run without it..
  old=Sys.getenv("GITHUB_PAT")
  Sys.setenv("GITHUB_PAT" = '')

  natmanager::install(collection = 'core', dependencies = TRUE,
                      upgrade.dependencies = TRUE, lib = liblocs)
  expect_equal(requireNamespace(pkgname, lib.loc = liblocs, quietly=TRUE),TRUE)

  #Set the pat again..
  Sys.setenv("GITHUB_PAT" = old)

})


test_that("list all natverse repos ", {
  # We need a GITHUB_PAT to query the github API
  skip_if_not(nzchar(Sys.getenv('GITHUB_PAT')), "Skipping as Github PAT unset")

  pkgs <- natmanager::list_repo()
  expect_is(pkgs, 'character')
  expect_true("nat" %in% pkgs)
})


test_that("check for versions of R ", {
  skip_if_not_installed('mockery')

  mockery::stub(system_requirements_ok, 'getRversion', package_version("4.0.2"))
  expect_warning(system_requirements_ok(), regexp = NA)

  mockery::stub(system_requirements_ok, 'getRversion', package_version("3.5"))
  expect_warning(system_requirements_ok())

  mockery::stub(system_requirements_ok, 'getRversion', package_version("3.4"))
  expect_error(system_requirements_ok())

})
