## tif: Text Interchange Formats

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/statsmaths/tif?branch=master&svg=true)](https://ci.appveyor.com/project/statsmaths/cleanNLP) [![Travis-CI Build Status](https://travis-ci.org/statsmaths/cleanNLP.svg?branch=master)](https://travis-ci.org/ropensci/tif)

This package describes and validates formats for storing
common object arising in text analysis as native R objects.
Representations of a text corpus, document term matrix, and
tokenized text are included. The tokenized text format is
extensible to include other annotations. There are two versions
of the corpus and tokens objects; packages should accept
both and return or coerce to at least one of these.

## Installation



## Installation

You can install the development version using devtools:

```{r}
devtools::install_github("ropensci/tif")
```

## Usage

The package can be used to check that a particular object is in a valid 
format. For example, here we see that the object `corpus` is a valid corpus
data frame:

```{r}
library(tif)
corpus <- data.frame(doc_id = c("doc1", "doc2", "doc3"),
                     text = c("Aujourd'hui, maman est morte.",
                      "It was a pleasure to burn.",
                      "All this happened, more or less."),
                     stringsAsFactors = FALSE)

tif_is_corpus_df(corpus)
```
```
TRUE
```

The package also has functions to convert between the list and data frame
formats for corpus and token object. For example:

```{r}
tif_as_corpus_character(corpus)
```
```
                              doc1                               doc2 
   "Aujourd'hui, maman est morte."       "It was a pleasure to burn." 
                              doc3 
"All this happened, more or less." 
```

Note that extra meta data columns will be lost in the conversion from a data
frame to a named character vector.

## Details

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
object is a data frame with at least two columns. There must be
a column called doc_id that is a character vector
with UTF-8 encoding. Document ids must be unique.
There must also be a column called token that must also be a
character vector in UTF-8 encoding.
Each individual token is represented by a single row in
the data frame. Addition token-level metadata columns
are allowed but not required. 

**tokens** (list) - A valid corpus tokens object is (possibly
named) list of character vectors. The character vectors, as
well as names, should be in UTF-8 encoding. No other
attributes should be present in either the list or any of its
elements.