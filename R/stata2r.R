#' Title
#'
#' @param scode
#'
#' @return
#' @export
#'
#' @examples
stata2r <- function(scode) {

  .func <- stringr::str_extract(scode, "^[a-z]+")
  .arg <- stringr::str_remove(scode, "^[a-z]+ ")

  if (.func == .arg) {
    eval(parse(text = stringr::str_glue('{.func}()')))
  } else {
    eval(parse(text = stringr::str_glue('{.func}("{.arg}")')))
  }

}
