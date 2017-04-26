# tif 0.2.0

* After a round of input for the initial version of the specification,
we decided to allow two formats for corpus and tokens objects. In addition
to the original data frame variants there is a character vector corpus
object and a list-based tokens object. Converts between the various types
are now included in the package.

### New Functions

* `tif_is_corpus_character` returns TRUE or FALSE for whether the input
is a valid character vector corpus object.

* `tif_is_tokens_list` returns TRUE or FALSE for whether the input
is a valid list-based tokens object.

* `tif_as_corpus_character` takes a valid tif corpus object and returns
a character vector corpus object.

* `tif_as_corpus_df` takes a valid tif corpus object and returns
a data frame corpus object.

* `tif_as_tokens_character` takes a valid tif tokens object and returns
a list-based tokens object.

* `tif_as_tokens_df` takes a valid tif tokens object and returns
a list-based tokens object.

### Renamed Functions

* The old validate functions have been renamed `tif_is_corpus_df`,
`tif_is_dtm` and `tif_is_tokens_df`. This is more in line with base-R
functions and seperates the "df" version of the corpus and tokens from
the alternative new forms.



# tif 0.1.0

* This is the initial implementation of the ideas discussed at
the rOpenSci Text Workshop from 21-22 April 2017.

### New Functions

* `tif_corpus_validate` returns TRUE or FALSE for whether the input
is a valid corpus object.

* `tif_dtm_validate` returns TRUE or FALSE for whether the input is
a valid document corpus object.

* `tif_tokens_validate` returns TRUE or FALSE for whether the input is
a valid tokens object.

### Known issues

* do not yet have a test suite for the package

* encoding checkin is not yet working

