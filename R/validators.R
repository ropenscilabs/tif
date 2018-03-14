#' Validate Corpus Data Frame Object
#'
#' A valid data frame corpus object is an object that
#  inherits a data frame. It has no row names and has at
#' least two columns. One column must be called doc_id
#' and be a character vector with UTF-8 encoding. Document
#' ids must be unique. There must also be a column called text
#' and must also be a character vector in UTF-8 encoding. Each
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
#' @example inst/examples/tif_is_corpus_df.R
#' @export
tif_is_corpus_df <- function(corpus, warn = FALSE) {

  if (!inherits(corpus, "data.frame")) {
    if (warn) warning("corpus object must inherit the data.frame class")
    return(FALSE)
  }

  if (ncol(corpus) <= 1L) {
    if (warn) warning("corpus object must contain at least two columns")
    return(FALSE)
  }

  if (!all(c("doc_id", "text") %in% names(corpus))) {
    if (warn) warning("corpus object must contain columns named ",
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

#' Validate Corpus Character Vector Object
#'
#' A valid character vector corpus object is an character
#' vector with UTF-8 encoding. If it has names, this should
#' be a unique character also in UTF-8 encoding. No other
#' attributes should be present.
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
#' note passed.
#'
#' @example inst/examples/tif_is_corpus_character.R
#' @export
tif_is_corpus_character <- function(corpus, warn = FALSE) {

  if (!is.character(corpus)) {
    if (warn) warning("corpus object must be a character vector")
    return(FALSE)
  }

  if (!is.null(names(corpus)) && any(duplicated(names(corpus)))) {
    if (warn) warning("names of corpus object must not be duplicated")
    return(FALSE)
  }

  if (!is.null(attributes(corpus)) && any(names(attributes(corpus)) != "names")) {
    if (warn) warning("corpus object should have no attributes other than 'names'")
    return(FALSE)
  }

  if (!is.null(names(corpus)) && !is.character(names(corpus))) {
    if (warn) warning("corpus object names should be a character vector")
    return(FALSE)
  }

  # if (Encoding(corpus) != "UTF-8") {
  #   if (warn) warning("corpus must be UTF-8 encoded")
  #   return(FALSE)
  # }

  # if (!is.null(names(corpus)) && Encoding(names(corpus)) != "UTF-8") {
  #   if (warn) warning("corpus names must be UTF-8 encoded")
  #   return(FALSE)
  # }

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
#' @example inst/examples/tif_is_dtm.R
#' @export
tif_is_dtm <- function(dtm, warn = FALSE) {

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

#' Validate Tokens Data Frame Object
#'
#' A valid tokens data frame object is a data frame or an
#' object that inherits a data frame. It has no row names
#' and has at least two columns. It must a contain column called
#' doc_id that is a character vector with UTF-8 encoding.
#' Document ids must be unique. It must also contain a column called
#' token that must also be a character vector in UTF-8 encoding.
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
#' @example inst/examples/tif_is_tokens_df.R
#' @export
tif_is_tokens_df <- function(tokens, warn = FALSE) {

  if (!inherits(tokens, "data.frame")) {
    if (warn) warning("tokens object must inherit the data.frame class")
    return(FALSE)
  }

  if (ncol(tokens) <= 1L) {
    if (warn) warning("tokens object must contain at least two columns")
    return(FALSE)
  }


  if (!all(c("doc_id", "token") %in% names(tokens))) {
    if (warn) warning("data frame must contain columns named",
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

#' Validate Tokens List Object
#'
#' A valid corpus tokens object is (possibly named) list of
#' character vectors. The character vectors, as well as
#' names, should be in UTF-8 encoding. No other attributes
#' should be present in either the list or any of its elements.
#'
#' @param tokens  a tokens object to test for validity
#' @param warn    logical. Should the function produce a
#'                verbose warning for the condition for which
#'                the validation fails. Useful for testing.
#' @return        a logical vector of length one indicating
#'                whether the input is a valid tokens
#'
#' @details
#' The tests are run sequentially and the function returns,
#' with a warning if the warn flag is set, on the first test
#' that fails. We use this implementation because some tests
#' may fail entirely or be meaningless if the prior ones are
#' note passed.
#'
#' @example inst/examples/tif_is_tokens_list.R
#' @export
tif_is_tokens_list <- function(tokens, warn = FALSE) {

  if (!is.list(tokens)) {
    if (warn) warning("tokens object must be a list")
    return(FALSE)
  }

  if (!is.null(names(tokens)) && any(duplicated(names(tokens)))) {
    if (warn) warning("names of tokens object must not be duplicated")
    return(FALSE)
  }

  if (!is.null(attributes(tokens)) && any(names(attributes(tokens)) != "names")) {
    if (warn) warning("tokens object should have no attributes other than 'names'")
    return(FALSE)
  }

  if (!is.null(names(tokens)) && !is.character(names(tokens))) {
    if (warn) warning("tokens object names should be a character vector")
    return(FALSE)
  }

  if (any(sapply(tokens, is.null))) {
    if (warn) warning("no elements of tokens should be 'NULL'")
    return(FALSE)
  }

  if (!all(sapply(tokens, is.character))) {
    if (warn) warning("elements of tokens should all be a character vectors")
    return(FALSE)
  }

  if (!all(sapply(lapply(tokens, attributes), is.null))) {
    if (warn) warning("elements of tokens should have no additional attributes")
    return(FALSE)
  }

  # if (!all(sapply(tokens, Encoding) == "UTF-8")) {
  #   if (warn) warning("elements of tokens must be UTF-8 encoded")
  #   return(FALSE)
  # }

  # if (!is.null(names(tokens)) && Encoding(names(tokens)) != "UTF-8") {
  #   if (warn) warning("tokens names must be UTF-8 encoded")
  #   return(FALSE)
  # }

  return(TRUE)
}
