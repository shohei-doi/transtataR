#' Title
#'
#' @param scode
#'
#' @return
#' @export
#'
#' @examples
stata2r <- function(scode) {

  if (!stringr::str_detect(scode, " ")) {

    .func <- scode
    eval(parse(text = stringr::str_glue('{.func}()')))

  } else {

    .func <- stringr::str_extract(scode, "^[a-z]+")
    .arg <- stringr::str_remove(scode, "^[a-z]+ ")

    if (!stringr::str_detect(scode, " if ")) {

      eval(parse(text = stringr::str_glue('{.func}("{.arg}")')))

    } else {

      .if <- stringr::str_remove(.arg, ".*if ")
      .arg <- stringr::str_remove(.arg, " if .+")
      eval(parse(text = stringr::str_glue('{.func}("{.arg}","{.if}")')))

    }

  }

}
