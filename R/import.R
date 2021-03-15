#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
import <- function(path) {

  use(stringr::str_remove(path, "excel "))

}
