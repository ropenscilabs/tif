devtools::load_all('tif')

context("test validators.R")

test_that("tif_is_corpus_df", {

	# A minimal valid corpus
	tc <- data.frame(doc_id='1', text='foobar', stringsAsFactors=F)
	expect_true(tif_is_corpus_df(tc))

	# Corpus with an additional class
	tc <- data.frame(doc_id='1', text='foobar', stringsAsFactors=F)
	class(tc) <- c('data.table', 'data.frame')
	expect_true(tif_is_corpus_df(tc))

	# Corpora with incorrect classes
	tc <- data.frame(doc_id='1', text='foobar', stringsAsFactors=F)
	expect_false(tif_is_corpus_df(as.matrix(tc)))
	expect_warning(
		tif_is_corpus_df(as.matrix(tc), warn=T),
		"corpus object must inherit the data.frame class"
	)
	expect_false(tif_is_corpus_df(unclass(tc)))
	expect_warning(
		tif_is_corpus_df(unclass(tc), warn=T),
		"corpus object must inherit the data.frame class"
	)

	# Corpora with only one column
	tc <- data.frame(doc_id='1', stringsAsFactors=F)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"corpus object must contain at least two columns"
	)
	tc <- data.frame(text=c('foobar'), stringsAsFactors=F)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"corpus object must contain at least two columns"
	)

	# A corpus with one incorrecly named column
	tc <- data.frame(foo='1', text='foobar', stringsAsFactors=F)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"first two columns of corpus object must be named 'doc_id' and 'text'"
	)
	# A corpus with the other incorrecly named column
	tc <- data.frame(doc_id='1', bar='foobar', stringsAsFactors=F)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"first two columns of corpus object must be named 'doc_id' and 'text'"
	)
	# A corpus with both columns incorrectly named
	tc <- data.frame(foo='1', bar='foobar', stringsAsFactors=F)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"first two columns of corpus object must be named 'doc_id' and 'text'"
	)


	# Corpora with correctly named columns, but in the wrong order
	tc <- data.frame(text='foobar', doc_id='1', stringsAsFactors=F)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"first two columns of corpus object must be named 'doc_id' and 'text'"
	)
	tc <- data.frame(baz='baz', doc_id='1', text='foobar', stringsAsFactors=F)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"first two columns of corpus object must be named 'doc_id' and 'text'"
	)
	tc <- data.frame(doc_id='1', baz='baz', text='foobar', stringsAsFactors=F)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"first two columns of corpus object must be named 'doc_id' and 'text'"
	)

	# A corpus with rownames
	tc <- data.frame(doc_id='1', text='foobar', stringsAsFactors=F)
	rownames(tc) <- 'baz'
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"corpus object should not contain row names"
	)

	# Corpora with incorrect column types
	tc <- data.frame(doc_id=1, text='foobar', stringsAsFactors=F)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"doc_id must be a character vector"
	)
	tc <- data.frame(doc_id=as.factor('1'), text='foobar', stringsAsFactors=F)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"doc_id must be a character vector"
	)

	tc <- data.frame(doc_id='1', text=1, stringsAsFactors=F)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"text must be a character vector"
	)
	tc <- data.frame(doc_id='1', text=as.factor('foobar'), stringsAsFactors=F)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"text must be a character vector"
	)

	# If both are incorrect, warning should be for doc_id
	tc <- data.frame(doc_id='1', text='foobar')
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"doc_id must be a character vector"
	)
	# If both are incorrect, warning should be for doc_id
	tc <- data.frame(doc_id=1, text=1)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"doc_id must be a character vector"
	)

	# A corpus with duplicated doc_id s
	tc <- data.frame(doc_id=c('1', '2', '1'), text=rep('foobar', 3), stringsAsFactors=F)
	expect_false(tif_is_corpus_df(tc))
	expect_warning(
		tif_is_corpus_df(tc, warn=T),
		"there are duplicated document ids in the corpus"
	)

})


