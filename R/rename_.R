#' Title
#'
#' @param vars
#'
#' @return
#' @export
#'
#' @examples
rename_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  oldvar <- stringr::str_extract(.arg, "^[^ ]+")
  newvar <- stringr::str_extract(.arg, "[^ ]+$")

  temp <<- eval(parse(text = stringr::str_glue("dplyr::rename(temp, {newvar} = {oldvar})")))

}
