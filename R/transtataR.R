#' Title
#'
#' @param do.file
#' @param path
#' @param execute
#'
#' @return
#' @export
#'
#' @examples
transtataR <- function(do.file, path = NULL, execute = FALSE) {

  scodes <- readLines(do.file)
  scodes <- stringr::str_replace_all(scodes, "\"", "'")

  if (execute) {

    stata2r(scodes[scodes != ""])

  } else {

    out <- stata2r(scodes[scodes != ""], trans = TRUE)


    n <- 50

    header <- c(
      "#",
      stringr::str_glue("# This code is converted from do file by transtataR {packageVersion('transtataR')}."),
      "#"
    )

    pkg <- main <- NULL

    for (i in seq_len(length(out))) {

      pkg <- rbind(pkg, out[[i]]$pkg)
      main <- c(main,
                stringr::str_glue("\n\n# {out[[i]]$scode} ---------------------------------\n\n"),
                out[[i]]$rcode)

    }

    main <- c(main, "\n# End of file")

    if (is.null(path)) {

      rscript <- file(stringr::str_replace(do.file, "do$", "R"))

    } else {

      rscript <- file(path)

    }

    pkg <- c("\n# Loading Packages ---------------------------------\n",
             stringr::str_c("library(", unique(pkg$package), ")"))

    writeLines(c(header, pkg, main), rscript)

    close(rscript)

  }

}
