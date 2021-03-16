#' Title
#'
#' @return
#' @export
#'
#' @examples
sum_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  if (is.null(.arg) && is.null(.if)) {

    rcode <- "skimr::skim(dat)"

  } else {

    rcode <- c(limit_data(.arg, .if), "skimr::skim(temp)")

  }

  return(rcode)

}
