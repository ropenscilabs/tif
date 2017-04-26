tokens <- list(doc1 = c("aujourd'hui", "maman", "est", "morte"),
               doc2 = c("it", "was", "a", "pleasure", "to", "burn"),
               doc3 = c("all", "this", "happened", "more", "or", "less"))
tif_is_tokens_list(tokens)

names(tokens) <- c("doc1", "doc2", "doc3")
tif_is_tokens_list(tokens)
