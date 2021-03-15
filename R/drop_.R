#' Title
#'
#' @param vars
#' @param .if
#'
#' @return
#' @export
#'
#' @examples
drop_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  if (is.null(.if)) {

    vars <- stringr::str_replace_all(.arg, " ", ", !")
    temp <<- dplyr::select(temp, !eval(parse(text = vars)))

  } else {

    temp <<- eval(parse(text = stringr::str_glue("dplyr::filter(temp, !{.if})")))

  }

}
