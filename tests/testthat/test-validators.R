test_that("tiFALSE_is_corpus_df", {
  # A minimal valid corpus
  tc <- data.frame(doc_id = "1", text = "foobar", stringsAsFactors = FALSE)
  expect_true(tif_is_corpus_df(tc))

  # Corpus with an additional class
  tc <- data.frame(doc_id = "1", text = "foobar", stringsAsFactors = FALSE)
  class(tc) <- c("data.table", "data.frame")
  expect_true(tif_is_corpus_df(tc))

  # Corpora with incorrect classes
  tc <- data.frame(doc_id = "1", text = "foobar", stringsAsFactors = FALSE)
  expect_false(tif_is_corpus_df(as.matrix(tc)))
  expect_warning(
    tif_is_corpus_df(as.matrix(tc), warn = TRUE),
    "corpus object must inherit the data.frame class"
  )
  expect_false(tif_is_corpus_df(unclass(tc)))
  expect_warning(
    tif_is_corpus_df(unclass(tc), warn = TRUE),
    "corpus object must inherit the data.frame class"
  )

  # Corpora with only one column
  tc <- data.frame(doc_id = "1", stringsAsFactors = FALSE)
  expect_false(tif_is_corpus_df(tc))
  expect_warning(
    tif_is_corpus_df(tc, warn = TRUE),
    "corpus object must contain at least two columns"
  )
  tc <- data.frame(text = c("foobar"), stringsAsFactors = FALSE)
  expect_false(tif_is_corpus_df(tc))
  expect_warning(
    tif_is_corpus_df(tc, warn = TRUE),
    "corpus object must contain at least two columns"
  )

  # A corpus with rownames
  tc <- data.frame(doc_id = "1", text = "foobar", stringsAsFactors = FALSE)
  rownames(tc) <- "baz"
  expect_false(tif_is_corpus_df(tc))
  expect_warning(
    tif_is_corpus_df(tc, warn = TRUE),
    "corpus object should not contain row names"
  )

  # Corpora with incorrect column types
  tc <- data.frame(doc_id = 1, text = "foobar", stringsAsFactors = FALSE)
  expect_false(tif_is_corpus_df(tc))
  expect_warning(
    tif_is_corpus_df(tc, warn = TRUE),
    "doc_id must be a character vector"
  )
  tc <- data.frame(doc_id = as.factor("1"), text = "foobar",
                   stringsAsFactors = FALSE)
  expect_false(tif_is_corpus_df(tc))
  expect_warning(
    tif_is_corpus_df(tc, warn = TRUE),
    "doc_id must be a character vector"
  )

  tc <- data.frame(doc_id = "1", text = 1, stringsAsFactors = FALSE)
  expect_false(tif_is_corpus_df(tc))
  expect_warning(
    tif_is_corpus_df(tc, warn = TRUE),
    "text must be a character vector"
  )
  tc <- data.frame(doc_id = "1", text = as.factor("foobar"),
                   stringsAsFactors = FALSE)
  expect_false(tif_is_corpus_df(tc))
  expect_warning(
    tif_is_corpus_df(tc, warn = TRUE),
    "text must be a character vector"
  )

  # If both are incorrect, warning should be for doc_id
  tc <- data.frame(doc_id  =  1, text = "foobar")
  expect_false(tif_is_corpus_df(tc))
  expect_warning(
    tif_is_corpus_df(tc, warn = TRUE),
    "doc_id must be a character vector"
  )
  # If both are incorrect, warning should be for doc_id
  tc <- data.frame(doc_id = 1, text = 1)
  expect_false(tif_is_corpus_df(tc))
  expect_warning(
    tif_is_corpus_df(tc, warn = TRUE),
    "doc_id must be a character vector"
  )

  # A corpus with duplicated doc_id s
  tc <- data.frame(doc_id = c("1", "2", "1"), text = rep("foobar", 3),
                   stringsAsFactors = FALSE)
  expect_false(tif_is_corpus_df(tc))
  expect_warning(
    tif_is_corpus_df(tc, warn = TRUE),
    "there are duplicated document ids in the corpus"
  )

})
