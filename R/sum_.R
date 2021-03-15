#' Title
#'
#' @return
#' @export
#'
#' @examples
sum_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  if (!is.null(.arg)) {

    vars <- stringr::str_replace_all(.arg, " ", ", ")
    temp <- eval(parse(text = stringr::str_glue("dplyr::select(temp, {vars})")))

  }

  if (!is.null(.if)) {

    temp <- eval(parse(text = stringr::str_glue("dplyr::filter(temp, {.if})")))

  }

  skimr::skim(temp)

}
