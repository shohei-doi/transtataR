limit_data <- function(.arg = NULL, .if = NULL) {

  rcode <- "temp <- dat"

  if (!is.null(.arg)) {

    .vars <- stringr::str_replace_all(.arg, " ", ", ")
    rcode <- c(rcode,
               stringr::str_glue("temp <- dplyr::select(temp, {.vars})"))

  }

  if (!is.null(.if)) {

    rcode <- c(rcode,
               stringr::str_glue("temp <- dplyr::filter(temp, {.if})"))

  }

  return(rcode)

}
