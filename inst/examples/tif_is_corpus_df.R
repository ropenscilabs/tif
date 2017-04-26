corpus <- data.frame(doc_id = c("doc1", "doc2", "doc3"),
                     text = c("Aujourd'hui, maman est morte.",
                      "It was a pleasure to burn.",
                      "All this happened, more or less."),
                     stringsAsFactors = FALSE)

tif_is_corpus_df(corpus)

corpus$author <- c("Camus", "Bradbury", "Vonnegut")
tif_is_corpus_df(corpus)
