#' Validate Corpus Object
#'
#' A valid corpus object is a data frame or object that
#  inherits a data frame. It has no row names and has at
#' least two columns. The first column is called doc_id
#' and is a character vector with UTF-8 encoding. Document
#' ids must be unique. The second column is called text and
#' must also be a character vector in UTF-8 encoding. Each
#' individual document is represented by a single row in
#' the data frame. Addition document-level metadata columns
#' and corpus level attributes are allowed but not required.
#'
#' @param corpus  a corpus object to test for validity
#' @param warn    logical. Should the function produce a
#'                verbose warning for the condition for which
#'                the validation fails. Useful for testing.
#' @return        a logical vector of length one indicating
#'                whether the input is a valid corpus
#'
#' @details
#' The tests are run sequentially and the function returns,
#' with a warning if the warn flag is set, on the first test
#' that fails. We use this implementation because some tests
#' may fail entirely or be meaningless if the prior ones are
#' note passed. For example, if the corpus object does not
#' have a variable named "text" it does not make sense to
#' check whether this column is a character vector.
#'
#' @example inst/examples/tif_corpus_validate.R
#' @export
tif_corpus_validate <- function(corpus, warn = FALSE) {

  if (!inherits(corpus, "data.frame")) {
    if (warn) warning("corpus object must inherit the data.frame class")
    return(FALSE)
  }

  if (ncol(corpus) <= 1L) {
    if (warn) warning("corpus object must contain at least two columns")
    return(FALSE)
  }

  if (!all(names(corpus)[1L:2L] == c("doc_id", "text"))) {
    if (warn) warning("first two columns of corpus object must be named",
                      "'doc_id' and 'text'")
    return(FALSE)
  }

  if (.row_names_info(corpus, type = 1) > 0) {
    if (warn) warning("corpus object should not contain row names")
    return(FALSE)
  }

  if (!is.character(corpus$doc_id)) {
    if (warn) warning("doc_id must be a character vector")
    return(FALSE)
  }

  if (!is.character(corpus$text)) {
    if (warn) warning("text must be a character vector")
    return(FALSE)
  }

  # if (Encoding(corpus$doc_id) != "UTF-8") {
  #   if (warn) warning("doc_id column must be UTF-8 encoded")
  #   return(FALSE)
  # }

  # if (Encoding(corpus$text) != "UTF-8") {
  #   if (warn) warning("text column must be UTF-8 encoded")
  #   return(FALSE)
  # }

  if (any(duplicated(corpus$doc_id))) {
    if (warn) warning("there are duplicated document ids in the corpus")
    return(FALSE)
  }

  return(TRUE)
}


#' Validate Document Term Matrix Object
#'
#' A valid document term matrix is a sparse matrix with
#' the row representing documents and columns representing
#' terms. The row names is a character vector giving the
#' document ids with no duplicated entries. The column
#' names is a character vector giving the terms of the
#' matrix with no duplicated entries. The spare matrix
#' should inherit from the Matrix class dgCMatrix.
#'
#' @param dtm    a document term matrix object to test
#'               the validity of
#' @param warn   logical. Should the function produce a
#'               verbose warning for the condition for which
#'               the validation fails. Useful for testing.
#' @return       a logical vector of length one indicating
#'               whether the input is a valid document term
#'               matrix
#'
#' @details
#' The tests are run sequentially and the function returns,
#' with a warning if the warn flag is set, on the first test
#' that fails. We use this implementation because some tests
#' may fail entirely or be meaningless if the prior ones are
#' note passed. For example, if the dtm object is not a matrix
#' it may not contain row or column names.
#'
#' @example inst/examples/tif_dtm_validate.R
#' @export
tif_dtm_validate <- function(dtm, warn = FALSE) {

  if (!inherits(dtm, "dgCMatrix")) {
    if (warn) warning("document term matrix object must inherit",
                      "the dgCMatrix class")
    return(FALSE)
  }

  if (is.null(colnames(dtm))) {
    if (warn) warning("document term matrix object must have column names")
    return(FALSE)
  }

  if (is.null(rownames(dtm))) {
    if (warn) warning("document term matrix object must have row names")
    return(FALSE)
  }

  if (!is.character(rownames(dtm))) {
    if (warn) warning("document term matrix object must have character",
                      "row names")
    return(FALSE)
  }

  if (!is.character(colnames(dtm))) {
    if (warn) warning("document term matrix object must have character",
                      "column names")
    return(FALSE)
  }

  if (any(duplicated(rownames(dtm)))) {
    if (warn) warning("document term matrix object has duplicated row names")
    return(FALSE)
  }

  if (any(duplicated(colnames(dtm)))) {
    if (warn) warning("document term matrix object has duplicated column",
                      "names")
    return(FALSE)
  }

  return(TRUE)
}

#' Validate Tokens Object
#'
#' A valid tokens object is a data frame or an object that
#  inherits a data frame. It has no row names and has at
#' least two columns. The first column is called doc_id
#' and is a character vector with UTF-8 encoding. Document
#' ids must be unique. The second column is called token
#' and must also be a character vector in UTF-8 encoding.
#' Each individual token is represented by a single row in
#' the data frame. Addition token-level metadata columns
#' are allowed but not required.
#'
#' @param tokens  a tokens object to test for validity
#' @param warn    logical. Should the function produce a
#'                verbose warning for the condition for which
#'                the validation fails. Useful for testing.
#' @return        a logical vector of length one indicating
#'                whether the input is a valid tokens object
#'
#' @details
#' The tests are run sequentially and the function returns,
#' with a warning if the warn flag is set, on the first test
#' that fails. We use this implementation because some tests
#' may fail entirely or be meaningless if the prior ones are
#' note passed. For example, if the tokens object does not
#' have a variable named "doc_id" it does not make sense to
#' check whether this column is a character vector.
#'
#' @example inst/examples/tif_tokens_validate.R
#' @export
tif_tokens_validate <- function(tokens, warn = FALSE) {

  if (!inherits(tokens, "data.frame")) {
    if (warn) warning("tokens object must inherit the data.frame class")
    return(FALSE)
  }

  if (ncol(tokens) <= 1L) {
    if (warn) warning("tokens object must contain at least two columns")
    return(FALSE)
  }

  if (all(names(tokens)[1L:2L] != c("doc_id", "token"))) {
    if (warn) warning("first two columns of tokens object must be named",
                      "'doc_id' and 'token'")
    return(FALSE)
  }

  if (.row_names_info(tokens, type = 1) > 0) {
    if (warn) warning("tokens object should not contain row names")
    return(FALSE)
  }

  if (!is.character(tokens$doc_id)) {
    if (warn) warning("doc_id must be a character vector")
    return(FALSE)
  }

  if (!is.character(tokens$token)) {
    if (warn) warning("text must be a character vector")
    return(FALSE)
  }

  # if (Encoding(tokens$doc_id) != "UTF-8") {
  #   if (warn) warning("doc_id column must be UTF-8 encoded")
  #   return(FALSE)
  # }

  # if (Encoding(tokens$token) != "UTF-8") {
  #   if (warn) warning("token column must be UTF-8 encoded")
  #   return(FALSE)
  # }

  return(TRUE)
}

