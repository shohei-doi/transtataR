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
  .arg <- stringr::str_remove(scode, .func)
  .if <- stringr::str_extract(scode, " if [^,]+,?")
  .opt <- stringr::str_extract(scode, "\\, ?.+")

  if (is.na(.if)) {

    .if <- NULL

  } else {

    .if <- stringr::str_remove(.if, ",")
    .arg <- stringr::str_remove(.arg, .if)
    .if <- stringr::str_remove(.if, " if ")

  }

  if (is.na(.opt)) {

    .opt <- NULL

  } else {

    .arg <- stringr::str_remove(.arg, .opt)
    .opt <- stringr::str_remove(.opt, "\\, ?")

  }

  if (.arg == "") {

    .arg <- NULL

  } else {

    .arg <- stringr::str_remove(.arg, "^ ")

  }

  .func <- stringr::str_c(.func, "_")
  eval(parse(text = .func))(.arg, .if, .opt)

}
