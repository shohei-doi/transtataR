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

    rcode <- stringr::str_glue('dat <<- readr::read_csv("{path}")')

  } else if(stringr::str_detect(path, ".tsv$")) {

    rcode <- stringr::str_glue('dat <<- readr::read_tsv("{path}")')

  } else if (stringr::str_detect(path, ".xls[x]*$")) {

    rcode <- stringr::str_glue('dat <<- readxl::read_excel("{path}")')

  } else if (stringr::str_detect(path, ".dta$")) {

    rcode <- stringr::str_glue('dat <<- haven::read_dta("{path}")')

  }

  rcode <- c(rcode,
             'names(dat) <<- stringr::str_replace_all(names(dat), " +", "_")')

  return(rcode)

}
