#' tif: Text Interchange Formats
#'
#' This package describes and validates formats for storing
#' common object arising in text analysis as native R objects.
#' Representations of a text corpus, document term matrix, and
#' tokenized text are included. The corpus and tokens objects
#' have multiple valid formats. Packages compliant with the
#' tif proposal should accept all valid formats and should
#' directly return, or provide conversion functions, for
#' converting outputs into at least one of the formats (when
#' applicable). The tokenized text format is extensible to
#' include other annotations such as part of speech tags and
#' named entities.
#'
#' @import Matrix
#'
#' @docType package
"_PACKAGE"
