## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----initialise---------------------------------------------------------------
library(proteomicsanalysis)

## ----load data----------------------------------------------------------------
example_data <- logFC_values_arabidopsis
file_with_gene_ids_FDR <- perseus_FDR_ttest(example_data)
nrow(file_with_gene_ids_FDR)


## ----logFC 1 FDR 0.05---------------------------------------------------------
file_with_gene_ids_FDR_significant <- perseus_ttest_significant(file_with_gene_ids_FDR, logfc_threshold = 1, FDR_threshold = 0.05)
nrow(file_with_gene_ids_FDR_significant)




## ----logFC 0 FDR 0.10---------------------------------------------------------
file_with_gene_ids_FDR_significant <- perseus_ttest_significant(file_with_gene_ids_FDR, logfc_threshold = 0, FDR_threshold = 0.10)
nrow(file_with_gene_ids_FDR_significant)


## ----volcano_plot, fig.height = 5, fig.width = 10-----------------------------
arabidopsis_volcano <- draw_volcano_plot(file_with_gene_ids_FDR, known_protein_names = proteins_name_arabidopsis_example, logfc_limit = 1, fdr_limit = -log10(0.05))
arabidopsis_volcano



