#!/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Runs FastQC quality control on all FASTQ files found recursively
#          under the current working directory. Supports both uncompressed
#          (.fastq) and gzip-compressed (.fastq.gz) files.
#
# WORKFLOW:
#   1. Creates an output directory: fastqc_results/
#   2. Uses find to locate all *.fastq and *.fastq.gz files recursively
#   3. Runs FastQC on each file, saving HTML/ZIP reports to fastqc_results/
#
# OUTPUT:
#   fastqc_results/*_fastqc.html  : Per-sample QC report (visual)
#   fastqc_results/*_fastqc.zip   : Per-sample QC data (machine-readable)
#
# DEPENDENCIES: FastQC (https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)

# Create output directory for FastQC results
mkdir -p fastqc_results

# Iterate over all FASTQ files (plain and gzipped) in subdirectories
find . -type f \( -name "*.fastq" -o -name "*.fastq.gz" \) | while read file; do
    # Run FastQC and save reports to the output directory
    fastqc "$file" -o fastqc_results/
done
