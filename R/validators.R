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

  if (all(names(corpus)[1L:2L] != c("doc_id", "text"))) {
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
