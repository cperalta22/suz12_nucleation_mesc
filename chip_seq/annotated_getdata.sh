#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Downloads external ChIP-seq samples from ENA (European Nucleotide
#          Archive) via FTP. These are publicly available datasets used as
#          external references or controls.
#
# DATA SOURCES:
#   Sample 1: Neural progenitor cell (GSM878558) — paired-end
#     Accession: SRX8073476 | Run: SRR11497564
#     URL: https://www.ebi.ac.uk/ena/browser/view/SRX8073476
#
#   Sample 2: Epithelium (GSM3020554) — single-end
#     Accession: SRX3734839 | Run: SRR6763506
#     URL: https://www.ebi.ac.uk/ena/browser/view/SRX3734839
#
#   Sample 3: Thymocyte (GSM1498452) — single-end
#     Accession: SRX692983 | Run: SRR1565996
#     URL: https://www.ebi.ac.uk/ena/browser/view/SRX692983
#
# FLAGS:
#   wget -nc : --no-clobber; skip downloads that would overwrite existing files

# --- Sample 1: Neural progenitor cell (GSM878558) ---
# Paired-end ChIP-seq; two FASTQ files (R1 and R2)
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR114/064/SRR11497564/SRR11497564_1.fastq.gz
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR114/064/SRR11497564/SRR11497564_2.fastq.gz

# --- Sample 2: Epithelium (GSM3020554) ---
# Single-end ChIP-seq; one FASTQ file
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR676/006/SRR6763506/SRR6763506.fastq.gz

# --- Sample 3: Thymocyte (GSM1498452) ---
# Single-end ChIP-seq; one FASTQ file
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR156/006/SRR1565996/SRR1565996.fastq.gz
