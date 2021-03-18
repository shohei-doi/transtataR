#' Title
#'
#' @param scode
#'
#' @return
#' @export
#'
#' @examples
stata2r <- function(..., show.code = FALSE, trans = FALSE) {

  scodes <- c(...)
  out <- list()

  for (i in seq_len(length(scodes))) {

    scode <- scodes[i]

    .func <- stringr::str_extract(scode, "^[a-z]+")
    .arg <- stringr::str_remove(scode, .func)
    .if <- stringr::str_extract(scode, " if [^,]+,?")
    .opt <- stringr::str_extract(scode, "\\, ?.+")

    if (is.na(.if)) {

      .if <- NULL

    } else {

      .if <- stringr::str_remove(.if, ",")
      .arg <- stringr::str_remove(.arg, .if)
      .if <- stringr::str_remove(.if, " if ")

      if (stringr::str_detect(.if, "\\.")) {

        .if <- stringr::str_glue("is.na({stringr::str_extract(.if, '[a-zA-Z0-9]+')})")

      }

    }

    if (is.na(.opt)) {

      .opt <- NULL

    } else {

      .arg <- stringr::str_remove(.arg, .opt)
      .opt <- stringr::str_remove(.opt, "\\, ?")

    }

    if (.arg == "") {

      .arg <- NULL

    } else {

      .arg <- stringr::str_remove(.arg, "^ ")

    }

    .func <- stringr::str_c(.func, "_")
    rcode <- eval(parse(text = .func))(.arg, .if, .opt)

    if (!show.code && !trans) {

      for (i in seq_len(length(rcode))) {

        if (stringr::str_detect(rcode[i], "(skim|head|broom)")) {

          if (stringr::str_detect(rcode[i], "tidy")) {

            cat("Coefficitnes:\n")

          } else if (stringr::str_detect(rcode[i], "glance")) {

            cat("Model summaries:\n")

          }

          print(eval(parse(text = rcode[i])))

          cat("\n")

        } else {

          eval(parse(text = rcode[i]))

        }

      }

    } else {

      rcode <- stringr::str_replace_all(rcode, "<<-", "<-")
      pkg <- NULL

      if (sum(stringr::str_detect(rcode, "::")) > 0) {

        pkg <- stringr::str_extract_all(rcode, "[a-zA-Z0-9_\\.]+::[a-zA-Z0-9_\\.]+",
                                        simplify = TRUE)
        pkg <- pkg[pkg[,1] != "",]
        pkg <- stringr::str_split(pkg, "::", simplify = TRUE)
        colnames(pkg) <- c("package", "function")
        pkg <- dplyr::as_tibble(pkg)

      }

      rcode <- stringr::str_remove_all(rcode, "[a-zA-Z0-9_\\.]+::")

      if (show.code) {

        cat("Stata code:\n")
        cat(scode)
        cat("\n\n")

        cat("R code:\n")

        for (i in seq_len(length(rcode))) {

          cat(rcode[i])
          cat("\n")

        }

        if (!is.null(pkg)) {

          cat("\nR packages:\n")
          print(pkg)
          cat("\n")

        }

      } else {

        out[[i]] <- list(scode = scode, rcode = rcode, pkg = pkg)

      }

    }

  }

  if (trans) {

    return(out)

  }

}
