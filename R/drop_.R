#' Title
#'
#' @param vars
#' @param .if
#'
#' @return
#' @export
#'
#' @examples
drop_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  if (!is.null(.arg)) {

    vars <- stringr::str_c("!c(", .arg, ")")
    vars <- stringr::str_replace_all(vars, " ", ", ")
    rcode <- c(rcode,
               stringr::str_glue("dat <<- dplyr::select(temp, {vars})"))

  }

  if (!is.null(.if)) {

    rcode <- c(rcode,
               stringr::str_glue("dat <<- dplyr::filter(temp, !{.if})"))

  }

  return(rcode)

}
