#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
insheet <- function(path) {

  use(stringr::str_remove(path, "using "))

}
