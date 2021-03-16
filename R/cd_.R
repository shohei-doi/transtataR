#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
cd_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  rcode <- stringr::str_glue('setwd("{.arg}")')
  return(rcode)

}
