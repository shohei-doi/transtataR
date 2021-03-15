#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
use_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  path <- stringr::str_remove_all(.arg, "'")

  if (stringr::str_detect(path, ".csv$")) {

    temp <<- readr::read_csv(path)

  } else if(stringr::str_detect(path, ".tsv$")) {

    temp <<- readr::read_tsv(path)

  } else if (stringr::str_detect(path, ".xls[x]*$")) {

    temp <<- readxl::read_excel(path)

  } else if (stringr::str_detect(path, ".dta$")) {

    temp <<- haven::read_dta(path)

  }

  names(temp) <<- stringr::str_remove_all(names(temp), "%")
  names(temp) <<- stringr::str_replace_all(names(temp), " +", "_")

}
