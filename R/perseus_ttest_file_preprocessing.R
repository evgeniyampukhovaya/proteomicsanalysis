# Functions to work with Perseus T Test results

#' Title Calculate FDR based on the list of p-values
#'
#' Calcualates BH FDR from the file in the Perseus output format. The input should already contain fold change and p-values
#' @param file A Perseus putput dataframe. Should have at least 3 columns named: Fasta.headers, Student.s.T.test.Difference, Student.s.T.test.p.value. For Arabidopsis datasets, the column ENSG containing gene AGIs is optional
#'
#' @return a fataframe with 4 or 5 columns: minus_log_p_val = -log10(p); logFC = log2(fold change); FDR calculated by BH method; Fasta_header from Uniprot; AGI (optionally)
#' @export
#'
#' @examples
#' @author Evgeniya Pukhovaya
perseus_FDR_ttest <- function(file){
  colnames_file <- colnames(file)
  colnames_needed <- c(grep('ENSG', colnames_file),
                       grep('Student.s.T.test.p.value', colnames_file),
                       grep('Student.s.T.test.Difference', colnames_file),
                       grep('Fasta.headers', colnames_file)
  )
  file <- file[,colnames_needed]
  if (length(colnames(file)) < 3) {
    stop('Not all the columns present')
  }
  if (length(colnames(file)) > 4){
    stop('Double column names')
  }
  if (length(colnames(file)) == 4) {
    colnames(file) <- c('AGI', 'minus_log_p_val', 'logFC', 'Fasta_header')
    file <- file |> dplyr::mutate(pval = 10 ^ (- .data$minus_log_p_val))
    file <- file |> dplyr::mutate(AGI = stringr::str_remove_all(.data$AGI, "[\r\n]"))
    file <- file |> dplyr::mutate(fdr_calc = stats::p.adjust(.data$pval, method = 'BH'))}
  if (length(colnames(file)) == 3) {
    colnames(file) <- c('minus_log_p_val', 'logFC', 'Fasta_header')
    file <- file |> dplyr::mutate(pval = 10 ^ (- .data$minus_log_p_val))
    file <- file |> dplyr::mutate(fdr_calc = stats::p.adjust(.data$pval, method = 'BH'))
  }
  return(file)
}





# perseus_FDR_ttest_arabidopsis <- function(file){
#   colnames_file <- colnames(file)
#   colnames_needed <- c(grep('ENSG', colnames_file),
#                        grep('Student.s.T.test.p.value', colnames_file),
#                        grep('Student.s.T.test.Difference', colnames_file),
#                        grep('Fasta.headers', colnames_file)
#   )
#   file <- file[,colnames_needed]
#   colnames(file) <- c('AGI', 'minus_log_p_val', 'logFC', 'Fasta_header')
#   file <- file |> dplyr::mutate(pval = 10^ (- minus_log_p_val))
#   file <- file |> dplyr::mutate(AGI = dplyr::str_remove_all(AGI, "[\r\n]"))
#   file <- file |> dplyr::mutate(FDR = p.adjust(pval, method = 'BH'))
#
#   return(file)
# }
#
# perseus_FDR_ttest_marchantia <- function(file){
#   colnames_file <- colnames(file)
#   colnames_needed <- c(grep('Student.s.T.test.p.value', colnames_file),
#                        grep('Student.s.T.test.Difference', colnames_file),
#                        grep('Fasta.headers', colnames_file)
#   )
#   file <- file[,colnames_needed]
#   colnames(file) <- c('minus_log_p_val', 'logFC', 'Fasta_header')
#   file <- file |> dplyr::mutate(pval = 10^ (- minus_log_p_val))
#   file <- file |> dplyr::mutate(FDR = p.adjust(pval, method = 'BH'))
#
#   return(file)
# }

