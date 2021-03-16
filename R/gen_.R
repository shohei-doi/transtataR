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

    rcode <- stringr::str_glue("dat <<- dplyr::mutate(dat, {.arg})")

  } else {

    oldvar <- stringr::str_extract(.arg, "^[^ =]+")
    newvar <- stringr::str_extract(.arg, "=.*$")
    newvar <- stringr::str_remove(newvar, "=[ ]*")
    rcode <-
      stringr::str_glue(
        "dat <<- dplyr::mutate(dat, {oldvar} = dplyr::if_else({.if}, {newvar}, {oldvar}))"
        )

  }

  return(rcode)

}
