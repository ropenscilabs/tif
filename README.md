### Text Interchange Formats

This package describes and validates formats for storing
common object arising in text analysis as native R objects.
Representations of a text corpus, document term matrix, and
tokenized text are included. The tokenized text format is
extensible to include other annotations.

**corpus** - A valid corpus object is a data frame or object that
least two columns. The first column is called doc_id
and is a character vector with UTF-8 encoding. Document
ids must be unique. The second column is called text and
must also be a character vector in UTF-8 encoding. Each
individual document is represented by a single row in
the data frame. Addition document-level metadata columns
and corpus level attributes are allowed but not required.

**dtm** - A valid document term matrix is a sparse matrix with
the row representing documents and columns representing
terms. The row names is a character vector giving the
document ids with no duplicated entries. The column
names is a character vector giving the terms of the
matrix with no duplicated entries. The sparse matrix
should inherit from the Matrix class dgCMatrix.

**tokens** - A valid tokens object is a data frame or an object that
least two columns. The first column is called doc_id
and is a character vector with UTF-8 encoding. Document
ids must be unique. The second column is called token
and must also be a character vector in UTF-8 encoding.
Each individual token is represented by a single row in
the data frame. Addition token-level metadata columns
are allowed but not required. 
