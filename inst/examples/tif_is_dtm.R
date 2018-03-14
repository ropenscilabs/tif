#' @importFrom Matrix Matrix
dtm <- Matrix::Matrix(0, ncol = 26, nrow = 5, sparse = TRUE)
colnames(dtm) <- LETTERS
rownames(dtm) <- sprintf("doc%d", 1:5)

tif_is_dtm(dtm)
