tokens <- data.frame(doc_id = c("doc1", "doc1", "doc1", "doc1",
                                "doc2",  "doc2", "doc2", "doc2",
                                "doc2", "doc2", "doc3", "doc3",
                                "doc3", "doc3", "doc3", "doc3"),
                     token = c("aujourd'hui", "maman", "est",
                               "morte", "it", "was", "a", "pleasure",
                               "to", "burn", "all", "this", "happened",
                               "more", "or", "less"))

tif_tokens_validate(tokens)

tokens$pos <- "NOUN"
tokens$NER <- ""
tokens$sentiment <- runif(16L)
tif_tokens_validate(tokens)
