#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Batch quality trimming and QC of paired-end FASTQ files using
#          Trim Galore (wrapper around Cutadapt + FastQC).
#
# WORKFLOW:
#   1. Reads a list of sample subdirectory names from ./dirs.txt
#   2. For each sample, enters its directory
#   3. Runs Trim Galore on paired-end reads (*R1* and *R2*)
#   4. Outputs trimmed FASTQ + FastQC reports to ../trim_n_fastqc/
#
# KEY PARAMETERS:
#   --paired      : Input files are paired-end; Trim Galore validates R1/R2 pairing
#   -j 30         : Use 30 CPU threads for gzip compression
#   --fastqc      : Run FastQC on trimmed reads automatically
#   -o ../trim_n_fastqc : Output directory for trimmed reads and QC reports
#
# INPUT:  ./dirs.txt (one sample subdirectory name per line)
# OUTPUT: ../trim_n_fastqc/ (trimmed FASTQ files + FastQC HTML/ZIP reports)

while read f
do
  cd $f
  trim_galore --paired -j 30 --fastqc -o ../trim_n_fastqc *R1* *R2*
  cd ..
done < ./dirs.txt
