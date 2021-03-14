#' Title
#'
#' @param fml
#'
#' @return
#' @export
#'
#' @examples
make_fml <- function(fml) {

  .y <- stringr::str_extract(fml, "[a-zA-Z0-9_\\.]+")
  .x <- stringr::str_remove(fml, "[a-zA-Z0-9_\\.]+ ")

  if (stringr::str_detect(fml, "c\\.")) {

    .cat0 <- stringr::str_extract_all(.x, "c\\.[^\\ #]+")[[1]]
    .cat1 <- stringr::str_remove(.cat0, "c\\.")
    .cat1 <- stringr::str_c("as.factor(", .cat1, ")")
    names(.cat1) <- .cat0
    .x <- stringr::str_remove_all(.x, .cat1)

  }

  .x <- stringr::str_replace_all(.x, " ", " + ")
  .x <- stringr::str_replace_all(.x, "#", "*")

  return(stringr::str_c(.y, " ~ ", .x))

}
