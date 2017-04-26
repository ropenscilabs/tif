### Text Interchange Formats

This package describes and validates formats for storing
common object arising in text analysis as native R objects.
Representations of a text corpus, document term matrix, and
tokenized text are included. The tokenized text format is
extensible to include other annotations. There are two versions
of the corpus and tokens objects; packages should accept
both and return or coerce to at least one of these.

**corpus** (data frame) - A valid corpus data frame object
is a data frame with at least two columns. The first column
is called doc_id and is a character vector with UTF-8 encoding. Document
ids must be unique. The second column is called text and
must also be a character vector in UTF-8 encoding. Each
individual document is represented by a single row in
the data frame. Addition document-level metadata columns
and corpus level attributes are allowed but not required.

**corpus** (character vector) - A valid character vector corpus
object is an character vector with UTF-8 encoding. If it has
names, this should be a unique character also in UTF-8
encoding. No other attributes should be present.

**dtm** - A valid document term matrix is a sparse matrix with
the row representing documents and columns representing
terms. The row names is a character vector giving the
document ids with no duplicated entries. The column
names is a character vector giving the terms of the
matrix with no duplicated entries. The sparse matrix
should inherit from the Matrix class dgCMatrix.

**tokens** (data frame) - A valid data frame tokens
object is a data frame with at least two columns. The
first column is called doc_id and is a character vector
with UTF-8 encoding. Document ids must be unique.
The second column is called token and must also be a
character vector in UTF-8 encoding.
Each individual token is represented by a single row in
the data frame. Addition token-level metadata columns
are allowed but not required. 

**tokens** (list) - A valid corpus tokens object is (possibly
named) list of character vectors. The character vectors, as
well as names, should be in UTF-8 encoding. No other
attributes should be present in either the list or any of its
elements.