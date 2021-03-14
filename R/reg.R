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

  .y <- stringr::str_extract(fml, "[a-zA-Z0-9_\\.]+")
  .x <- stringr::str_remove(fml, "[a-zA-Z0-9_\\.]+ ")
  .x <- stringr::str_replace_all(.x, " ", "+")

  if (is.null(.if)) {

    out <- eval(parse(text = stringr::str_c("lm(", .y, "~", .x, ", data = temp)")))

  } else {

    temp <- eval(parse(text = stringr::str_glue("dplyr::filter(temp, {.if})")))
    out <- eval(parse(text = stringr::str_c("lm(", .y, "~", .x, ", data = temp)")))

  }

  print(broom::tidy(out, conf.int = TRUE))
  print(broom::glance(out))

}
