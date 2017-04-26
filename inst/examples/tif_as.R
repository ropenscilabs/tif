# coerce corpus object
corpus <- c("Aujourd'hui, maman est morte.",
            "It was a pleasure to burn.",
            "All this happened, more or less.")
names(corpus) <- c("Camus", "Bradbury", "Vonnegut")

new <- tif_as_corpus_df(corpus)
new
tif_as_corpus_character(new)

# coerce tokens object
tokens <- list(doc1 = c("aujourd'hui", "maman", "est", "morte"),
               doc2 = c("it", "was", "a", "pleasure", "to", "burn"),
               doc3 = c("all", "this", "happened", "more", "or", "less"))

new <- tif_as_tokens_df(tokens)
new
tif_as_tokens_list(new)

