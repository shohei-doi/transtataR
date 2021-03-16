#' Title
#'
#' @param fml
#' @param .if
#'
#' @return
#' @export
#'
#' @examples
reg_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  fml <- make_fml(.arg)

  if (!is.null(.if)) {

    rcode <- stringr::str_glue("model <<- lm({fml}, data = dat, if = .if)")

  }

  rcode <- stringr::str_glue("model <<- lm({fml}, data = dat)")


  rcode <- c(rcode,
             "broom::tidy(model, conf.int = TRUE)",
             "broom::glance(model)")

  return(rcode)

}
