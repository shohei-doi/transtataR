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

    temp <- eval(parse(text = stringr::str_glue("dplyr::filter(temp, {.if})")))

  }

  out <<- eval(parse(text = stringr::str_glue("lm({fml}, data = temp)")))


  knitr::kable(list(broom::tidy(out, conf.int = TRUE),
                    broom::glance(out)))

}
