test_that("installation works", {

  # This test requires installation and should not be run on CRAN
  skip_on_cran()
  # I have not figured out how to deal with sysreqs + pak on GHA in check
  skip_on_ci()
  on_github=nzchar(Sys.getenv('GITHUB_ACTIONS'))

  tmproot <- if(on_github) "/home/runner/work/_temp/" else tempfile()
  if(!file.exists(tmproot))
    dir.create(tmproot, showWarnings = F)
  # use a temporary location except on github actions
  if(on_github) {
    liblocs <- .libPaths()[[1L]]
    # pak warns against this but otherwise have sysreqs problems
    ucd=rappdirs::user_cache_dir()
  } else {
    on.exit(unlink(tmproot, recursive = T))
    liblocs <- file.path(tmproot, "Library")
    ucd <- file.path(tmproot, "ucd")
  }
  if(!file.exists(liblocs))
    dir.create(liblocs, showWarnings = F)
  if(!file.exists(ucd))
    dir.create(ucd, showWarnings = F)

  #unset PAT as core installation should be able to run without it
  # R_USER_CACHE_DIR is required by pak's cache mechanism
  withr::local_envvar(GITHUB_PAT="",
                      R_USER_CACHE_DIR=ucd)

  # make sure we have CRAN repo specified
  r = getOption("repos")
  r["CRAN"] = "https://cloud.r-project.org"
  withr::local_options(repos = r)

  # we will use this as signal package to check install has completed
  pkgname <- 'nat.templatebrains'
  natmanager::install(collection = 'core', dependencies = TRUE,
                      upgrade.dependencies = FALSE, lib = liblocs)
  expect_true(requireNamespace(pkgname, lib.loc = liblocs, quietly=TRUE))
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
