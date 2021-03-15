#' Title
#'
#' @param .arg
#' @param .if
#' @param .opt
#'
#' @return
#' @export
#'
#' @examples
browse_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  if (!is.null(.arg)) {

    vars <- stringr::str_replace_all(.arg, " ", ", ")
    temp <- dplyr::select(temp, eval(parse(text = vars)))

  }

  if (!is.null(.if)) {

    temp <- dplyr::filter(temp, eval(parse(text = .if)))

  }

  View(temp)

}
