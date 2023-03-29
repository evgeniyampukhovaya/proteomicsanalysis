
# proteomicsanalysis

<!-- badges: start -->
<!-- badges: end -->

The goal of proteomicsanalysis is to provide statistical analysis and visualisation of interactomics datasets; it will eventually accept MaxQuant LFQ values and generate a list of significantly enriched proteins in the data; for now, it operates with the putput of Perseus

## Installation

You can install the development version of proteomicsanalysis like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
```

## Example

This is a basic example which shows you how to calculate FDR for Perseus ourpur files from 2 plant species - Arabidopsis thaliana and Marchantia polymorpha

``` r
library(proteomicsanalysis)
# The package can select columns from Perseus putput file; 
# By default, it uses fasta headers as protein IDs 
# If the file comes from Arabidopsis, it can also keep AGI gene IDs 
# Here are two usage examples - from Arabidopsis (with gene IDs) and from Marchantia (another species that has different format of gene IDs, so they are omitted)
file_with_gene_ids <- logFC_values_arabidopsis
file_without_gene_ids <- logFC_values_marchantia

# Calculate FDR 

file_with_gene_ids_FDR <- perseus_FDR_ttest(file_with_gene_ids)
head(file_with_gene_ids_FDR)

file_without_gene_ids_FDR <- perseus_FDR_ttest(file_without_gene_ids)
head(file_without_gene_ids_FDR)

# Make a list of only significant hits (filter based on FDR and logFC)

file_with_gene_ids_FDR_significant <- perseus_ttest_significant(file_with_gene_ids_FDR, logfc_threshold = 1, FDR_threshold = 0.05)
min(file_with_gene_ids_FDR_significant$logFC)
max(file_with_gene_ids_FDR_significant$FDR)

# Draw volcano plots 
arabidopsis_volcano <- draw_volcano_plot(file_with_gene_ids_FDR)
arabidopsis_volcano
# For Arabidopsis, you can label proteins of interest if you supply the dataframe with gene names
arabidopsis_volcano <- draw_volcano_plot(file_with_gene_ids_FDR, known_protein_names = proteins_name_arabidopsis_example)
arabidopsis_volcano

# For other species, labeling of proteins is not possible yet
marchantia_volcano <- draw_volcano_plot(file_without_gene_ids_FDR)
marchantia_volcano

```

