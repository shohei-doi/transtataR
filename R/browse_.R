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

  if (is.null(.arg) && is.null(.if)) {

    rcode <- "View(dat)"

  } else {

    rcode <- c(limit_data(.arg, .if), "View(temp)")

  }

  return(rcode)

}
