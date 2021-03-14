#' Title
#'
#' @param vars
#' @param .if
#'
#' @return
#' @export
#'
#' @examples
keep <- function(vars = NULL, .if = NULL) {

  if (is.null(.if)) {

    vars <- stringr::str_replace_all(vars, " ", ", ")
    temp <<- eval(parse(text = stringr::str_glue("dplyr::select(temp, {vars})")))

  } else {

    temp <<- eval(parse(text = stringr::str_glue("dplyr::filter(temp, {.if})")))

  }

}
