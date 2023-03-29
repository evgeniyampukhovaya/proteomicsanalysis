# Function to select significan values from the list of p values
#' Select statisticaly significant hits
#'
#' Filters the dataframe according to two threshold values: FDR < FDR_threshold and logFC > logFC_threshold
#' @param file an output of perseus_FDR_ttest function or a dataframe with at least three columns (FDR, logFC, gene/protein ID)
#' @param logfc_threshold a fold change threshold
#' @param FDR_threshold a fold discovery rate threshold
#'
#' @return a dataframe with the same amount of columns as input filtered according to logFC and FDR thresholds
#' @export
#'
#' @examples
#' @author Evgeniya Pukhovaya
perseus_ttest_significant <- function(file, logfc_threshold = 0, FDR_threshold = 0.1){
  file <- file |> dplyr::filter (fdr_calc < FDR_threshold, logFC > logfc_threshold)
  return(file)
}

