# natmanager 0.4.8

* Update to new style GitHub PAT
* Recommend R > 4.0.2 for `natverse`
* catch error in some situations when no GitHub PAT is set
* moved CI to GitHub actions

# natmanager 0.4.7

* Bug fixes due to changes in `usethis` package resulting in deprecation of GitHub related APIs. Bump up version
  for preparation of package update on `CRAN`

# natmanager 0.4.6

* provide options for installing non-natverse packages via `natmanager`. Bump up version
  for preparation of package update on `CRAN`

# natmanager 0.4.5

* use new private `system_requirements_ok` function during install. Right now
this only checks for xquartz on macosx but additional checks or suggestions may
be added in future.

# natmanager 0.4.4

* use `R_REMOTES_STANDALONE` environment variable to try to prevent some Windows
  installation issues. See https://github.com/r-lib/remotes#standalone-mode.

# natmanager 0.4.3

* Fix bug in `selfupdate()` recall on restart

# natmanager 0.4.2

* `selfupdate()` tweaks: restart `install()` process after session restart when
  possible, don't stop after restart, `force` option.

# natmanager 0.4.1

* give `install()` the options to install specific packages rather than 
  collections.

# natmanager 0.4.0

* use bundled PAT when nothing else available

# natmanager 0.3.0

* option to install a limited core or the full natverse. 
  `install('core')` should not require a GitHub account and PAT
* move install instructions to the natverse.org/install website
* more hand-holding when setting the GITHUB_PAT
* only check the GITHUB_PAT when installing the full natverse

# natmanager 0.2.0

* add `selfupdate()` function
* make install more resistant to warnings especially prevalent on Windows

# natmanager 0.1.0

* First version on CRAN
