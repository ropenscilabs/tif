#' Coerce Between Tif Object Specifications
#'
#' These functions convert between the various valid
#' formats for corpus and tokens objects. By using these
#' in other packages, maintainers need to only handle
#' whichever specific format they would like to work
#' with, but gain the freedom to output (or convert
#' into) the one most suited to their package's paradigm.
#'
#' @param corpus    valid tif corpus object to coerce
#' @param tokens    valid tif tokens object to coerce
#'
#' @details
#' No explicit checking is done on the input; the output
#' is guaranteed to be valid only if the input is a valid
#' format. In fact, we make an effort to not modify an
#' object that appears to be in the required format already
#' due to R's copy on modify semantics.
#'
#' @example inst/examples/tif_as.R
#' @name tif_as
NULL

#' @rdname tif_as
#' @export
tif_as_corpus_character <- function(corpus) {
  if (!is.character(corpus)) {
    # Need to convert from data frame
    out <- as.character(corpus[[2]])
    names(out) <- corpus[[1]]
  } else {
    out <- corpus
  }

  return(out)
}

#' @rdname tif_as
#' @export
tif_as_corpus_df <- function(corpus) {
  if (!inherits(corpus, "data.frame")) {
    # Need to convert from character
    if (is.null(names(corpus))) {
      doc_id <- sprintf("doc%d", 1:length(corpus))
    } else {
      doc_id <- names(corpus)
    }
    out <- data.frame(doc_id = doc_id, text = as.character(corpus),
                      stringsAsFactors = FALSE)
  } else {
    out <- corpus
  }

  return(out)
}

#' @rdname tif_as
#' @export
tif_as_tokens_df <- function(tokens) {
  if (!inherits(tokens, "data.frame")) {
    # Need to convert from list to data frame
    if (is.null(names(tokens))) {
      doc_id <- sprintf("doc%d", 1:length(tokens))
    } else {
      doc_id <- names(tokens)
    }
    doc_id <- mapply(function(u, v) rep(u, length(v)), doc_id, tokens)
    out <- data.frame(doc_id = unlist(doc_id, use.names = FALSE),
                      token = unlist(tokens, use.names = FALSE),
                      stringsAsFactors = FALSE)
  } else {
    out <- tokens
  }

  return(out)
}

#' @rdname tif_as
#' @export
tif_as_tokens_list <- function(tokens) {
  if (inherits(tokens, "data.frame")) {
    # Need to convert from data frame to list
    out <- split(tokens[[2]], tokens[[1]])
  } else {
    out <- tokens
  }

  return(out)
}
