#' Coerce Between tif Object Specifications
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

#' @export
#' @rdname tif_as
tif_as_corpus_character <- function(corpus) {
  UseMethod("tif_as_corpus_character")
}

#' @rdname tif_as
#' @export
tif_as_corpus_character.default <- function(corpus) {

  nd <- length(dim(corpus))
  if (nd <= 1L) {
    out <- as.character(corpus)
  } else if (nd == 2L) {
    out <- as.data.frame(corpus)
  } else {
    stop(sprintf("Cannot convert object of class %s to tif corpus",
                 class(corpus)))
  }

  return(out)
}

#' @rdname tif_as
#' @export
tif_as_corpus_character.character <- function(corpus) {
  return(corpus)
}


#' @rdname tif_as
#' @export
tif_as_corpus_character.data.frame <- function(corpus) {

  out <- as.character(corpus$text)
  names(out) <- corpus$doc_id

  return(out)
}

#' @export
#' @rdname tif_as
tif_as_corpus_df <- function(corpus) {
  UseMethod("tif_as_corpus_df")
}

#' @rdname tif_as
#' @export
tif_as_corpus_df.default <- function(corpus) {

  nd <- length(dim(corpus))
  if (nd <= 1L) {
    out <- as.character(corpus)
    tif_as_corpus_df(out)
  } else if (nd == 2L) {
    out <- as.data.frame(corpus)
  } else {
    stop(sprintf("Cannot convert object of class %s to tif corpus",
                 class(corpus)))
  }

  return(out)
}

#' @rdname tif_as
#' @export
tif_as_corpus_df.character <- function(corpus) {

  # Need to convert from character
  if (is.null(names(corpus))) {
    doc_id <- sprintf("doc%d", seq_along(corpus))
  } else {
    doc_id <- names(corpus)
  }
  out <- data.frame(doc_id = doc_id, text = as.character(corpus),
                    stringsAsFactors = FALSE)
  return(out)
}

#' @rdname tif_as
#' @export
tif_as_corpus_df.data.frame <- function(corpus) {
  return(corpus)
}

#' @export
#' @rdname tif_as
tif_as_tokens_df <- function(tokens) {
  UseMethod("tif_as_tokens_df")
}

#' @rdname tif_as
#' @export
tif_as_tokens_df.default <- function(tokens) {

  nd <- length(dim(tokens))
  if (nd == 2L) {
    out <- as.data.frame(tokens)
    tif_as_tokens_df(out)
  } else {
    stop("Cannot convert object of class ", class(tokens),
         " to tif tokens")
  }

  return(out)
}

#' @rdname tif_as
#' @export
tif_as_tokens_df.list <- function(tokens) {

  if (is.null(names(tokens))) {
    doc_id <- sprintf("doc%d", seq_along(tokens))
  } else {
    doc_id <- names(tokens)
  }
  doc_id <- rep(doc_id, lengths(tokens))
  out <- data.frame(doc_id = unlist(doc_id, use.names = FALSE),
                    token = unlist(tokens, use.names = FALSE),
                    stringsAsFactors = FALSE)

  return(out)
}


#' @rdname tif_as
#' @export
tif_as_tokens_df.data.frame <- function(tokens) {
  return(tokens)
}


#' @export
#' @rdname tif_as
tif_as_tokens_list <- function(tokens) {
  UseMethod("tif_as_tokens_list")
}

#' @rdname tif_as
#' @export
tif_as_tokens_list.default <- function(tokens) {

  nd <- length(dim(tokens))
  if (nd == 2L) {
    out <- as.data.frame(tokens)
  } else {
    stop("Cannot convert object of class ", class(tokens),
         " to tif tokens")
  }

  return(out)
}

#' @rdname tif_as
#' @export
tif_as_tokens_list.list <- function(tokens) {
  return(tokens)
}


#' @rdname tif_as
#' @export
tif_as_tokens_list.data.frame <- function(tokens) {
  out <- split(tokens$token, tokens$doc_id)
  return(out)
}
