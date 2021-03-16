#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
save_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  path <- stringr::str_remove_all(.arg, "'")

  if (stringr::str_detect(path, ".csv$")) {

    rcode <- stringr::str_glue('readr::write_csv(temp, {path})')

  } else if(stringr::str_detect(path, ".tsv$")) {

    rcode <- stringr::str_glue('readr::write_tsv(temp, {path})')

  } else if (stringr::str_detect(path, ".dta$")) {

    rcode <- stringr::str_glue('haven::write_dta(temp, {path})')

  }

  return(rcode)

}
