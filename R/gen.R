#' Title
#'
#' @param newvar
#' @param .if
#'
#' @return
#' @export
#'
#' @examples
gen <- function(newvar, .if = NULL) {

  if (is.null(.if)) {

    temp <<- eval(parse(text = stringr::str_glue("dplyr::mutate(temp, {newvar})")))

  } else {

    oldvar <- stringr::str_extract(newvar, "^[^ =]+")
    newvar <- stringr::str_extract(newvar, "=.*$")
    newvar <- stringr::str_remove(newvar, "=[ ]*")
    temp <<- eval(parse(text = stringr::str_glue("dplyr::mutate(temp, {oldvar} =
                                                 dplyr::if_else({.if}, {newvar}, {oldvar}))")))

  }

}
