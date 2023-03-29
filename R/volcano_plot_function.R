#' Title Draw volcano plot
#'
#' Draw a volcano plot for the proteomics dataset based on logFC and FDR values
#' @param file_for_analysis a dataframe - output of perseus_FDR_ttest or a dataframe with at least 2 columns: logFC and FDR
#' @param logfc_limit - a threshold for logFC to draw a line on a plot
#' @param fdr_limit - a threshold for FDR to draw a line on a plot
#' @param known_protein_names - an optional gene names for Arabidopsis AGIs
#'
#' @return a ggplot object - volcano plot
#' @export
#'
#' @examples
#' @author Evgeniya Pukhovaya
draw_volcano_plot <- function(file_for_analysis, logfc_limit = 2.5, fdr_limit = -log10(0.05), known_protein_names = NULL){
    if(!missing(known_protein_names)){
      file_for_analysis <- dplyr::left_join(file_for_analysis, known_protein_names, by = 'AGI')

    } else {
      file_for_analysis <- file_for_analysis |> dplyr::mutate(Trivial = NA)
    }
    file_for_analysis <- file_for_analysis |> dplyr::mutate(dot_colour_plot = dplyr::case_when(is.na(.data$Trivial) ~ 'grey', !is.na(.data$Trivial) ~ 'black'))
    file_for_analysis <- file_for_analysis |> dplyr::mutate(minus_log10_FDR = - log10(.data$fdr_calc))
    final_volcano <- ggplot2::ggplot(file_for_analysis, ggplot2::aes(x = logFC, y = minus_log10_FDR)) +
      ggplot2::geom_point(ggplot2::aes(color = dot_colour_plot, size = dot_colour_plot)) +
      ggplot2::geom_vline(xintercept = logfc_limit, colour = 'red', alpha = 0.3) +
      ggplot2::geom_vline(xintercept = -logfc_limit, colour = 'red', alpha = 0.3) +
      ggplot2::geom_hline(yintercept = fdr_limit, colour = 'red', alpha = 0.3) +
      ggplot2::xlim(c(-15, 15)) +
      ggplot2::ylim(c(0, 5)) +
      ggplot2::xlab("logFC bait-coltrol") + ggplot2::ylab("-log10 FDR") +
        ggrepel::geom_text_repel(ggplot2::aes(label = ifelse((dot_colour_plot == 'black'), as.character(Trivial),'')), point.size = 1, max.overlaps = Inf, size = 2, fontface = 2, segment.linetype = 3) +
      ggplot2::scale_color_manual(values = c("grey" = "grey", 'black' = 'black')) +
      ggplot2::scale_size_manual (values = c ("grey" = 0.3, 'black' = 0.8)) +
      ggplot2::theme_bw() +
      ggplot2::theme(legend.position = "none")
  return(final_volcano)
}
