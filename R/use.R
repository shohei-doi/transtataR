#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
use <- function(path) {

  path <- stringr::str_remove(path, ",[ ]*clear$")

  if (stringr::str_detect(path, ".csv$")) {
    temp <<- readr::read_csv(path)
  } else if (stringr::str_detect(path, ".xls[x]*$")) {
    temp <<- readxl::read_excel(path)
  } else if (stringr::str_detect(path, ".dta$")) {
    temp <<- haven::read_dta(path)
  }

}
