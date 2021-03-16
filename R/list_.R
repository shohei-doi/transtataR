#' Title
#'
#' @return
#' @export
#'
#' @examples
list_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  if (is.null(.arg) && is.null(.if)) {

    rcode <- "head(dat)"

  } else {

    rcode <- c(limit_data(.arg, .if), "head(temp)")

  }

  return(rcode)

}
