#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
outsheet_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  save_(stringr::str_remove(.arg, "using "), .if, .opt)

}
