.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    pkgname, " v",
    packageVersion(pkgname),
    " will be the final version. ",
    "At the end of 2023, ",
    "the package will be archived in favor of pharmaversesdtm."
  )
}
