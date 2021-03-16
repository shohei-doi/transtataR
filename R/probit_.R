#' Title
#'
#' @param fml
#' @param .if
#'
#' @return
#' @export
#'
#' @examples
probit_ <- function(.arg = NULL, .if = NULL, .opt = NULL) {

  fml <- make_fml(.arg)

  if (!is.null(.if)) {

    rcode <-
      stringr::str_glue(
        'model <<- glm({fml}, family = binomial(link = "probit"), data = dat, if = .if)'
        )

  }

  rcode <-
    stringr::str_glue(
      'model <<- glm({fml}, family = binomial(link = "probit"), data = dat)'
    )

  rcode <- c(rcode,
             "broom::tidy(model, conf.int = TRUE)",
             "broom::glance(model)")

  return(rcode)

}
