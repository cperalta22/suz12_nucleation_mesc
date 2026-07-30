#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: One-shot environment bootstrap for Jupyter-based bioinformatics
#          analysis. Installs core bioinformatics tools, R with essential
#          packages, and JupyterLab with R kernel support.
#
# PACKAGES INSTALLED:
#   Bioinformatics CLI tools:
#     - bedtools          : Genomic interval arithmetic
#     - bioconductor-deseq2 : Differential expression analysis (R/Bioconductor)
#
#   Jupyter ecosystem:
#     - jupyter-lsp       : Language Server Protocol for notebooks
#     - jupyterlab        : IDE for notebooks
#     - pip               : Python package installer (via conda)
#
#   R statistical environment:
#     - r-car             : Companion to Applied Regression
#     - r-codetools       : Code analysis tools for R
#     - r-irkernel        : R kernel for Jupyter
#     - r-tidyverse       : Data science ecosystem (ggplot2, dplyr, tidyr, etc.)
#
# CHANNELS: bioconda (bioinformatics) + r (R packages)
#
# DEPENDENCIES: mamba (fast drop-in replacement for conda)

mamba install -c bioconda -c r bedtools bioconductor-deseq2 jupyter-lsp jupyterlab pip r-car r-codetools r-irkernel r-tidyverse
