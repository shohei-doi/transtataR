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
  path <- stringr::str_remove(path, ",[ ]*replace$")

  if (stringr::str_detect(path, ".csv$")) {

    readr::write_csv(temp, path)

  } else if(stringr::str_detect(path, ".tsv$")) {

    readr::write_tsv(path)

  } else if (stringr::str_detect(path, ".dta$")) {

    haven::write_dta(temp, path)

  }

}
