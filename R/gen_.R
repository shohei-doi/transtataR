#' Title
#'
#' @param newvar
#' @param .if
#'
#' @return
#' @export
#'
#' @examples
gen_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  if (is.null(.if)) {

    temp <<- eval(parse(text = stringr::str_glue("dplyr::mutate(temp, {.arg})")))

  } else {

    oldvar <- stringr::str_extract(.arg, "^[^ =]+")
    newvar <- stringr::str_extract(.arg, "=.*$")
    newvar <- stringr::str_remove(newvar, "=[ ]*")
    temp <<- eval(parse(text = stringr::str_glue("dplyr::mutate(temp, {oldvar} =
                                                 dplyr::if_else({.if}, {newvar}, {oldvar}))")))

  }

}
