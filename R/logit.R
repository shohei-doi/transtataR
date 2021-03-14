#' Title
#'
#' @param fml
#' @param .if
#'
#' @return
#' @export
#'
#' @examples
logit <- function(fml, .if = NULL) {

  fml <- make_fml(fml)

  if (!is.null(.if)) {

    temp <- eval(parse(text = stringr::str_glue("dplyr::filter(temp, {.if})")))

  }

  out <- eval(parse(text = stringr::str_glue("glm({fml},
                                             family = binomial(link = 'logit'),
                                             data = temp)")))

  print(broom::tidy(out, conf.int = TRUE))
  print(broom::glance(out))

}
