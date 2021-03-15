#' Title
#'
#' @param fml
#' @param .if
#'
#' @return
#' @export
#'
#' @examples
reg <- function(fml, .if = NULL) {

  fml <- make_fml(fml)

  if (!is.null(.if)) {

    temp <- eval(parse(text = stringr::str_glue("dplyr::filter(temp, {.if})")))

  }

  out <<- eval(parse(text = stringr::str_glue("lm({fml}, data = temp)")))


  knitr::kable(list(broom::tidy(out, conf.int = TRUE),
                    broom::glance(out)))

}
