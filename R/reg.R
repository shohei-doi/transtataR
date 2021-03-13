#' Title
#'
#' @param fml 
#'
#' @return
#' @export
#'
#' @examples
reg <- function(fml) {
  
  .y <- stringr::str_extract(fml, "[a-zA-Z0-9_\\.]+")
  .x <- stringr::str_remove(fml, "[a-zA-Z0-9_\\.]+ ")
  .x <- stringr::str_replace_all(.x, " ", "+")
  
  out <- eval(parse(text = stringr::str_c("lm(", .y, "~", .x, ", data = temp)")))
  broom::tidy(out, conf.int = TRUE)
  
}