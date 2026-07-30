#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Automated Bowtie2 alignment pipeline for ChIP-seq differential
#          binding analysis. Aligns trimmed paired-end reads to the mouse
#          genome (mm10), converts SAM to sorted BAM in a single pipe.
#
# WORKFLOW (per sample, read from conditions_chipdiffs.txt):
#   1. Locate trimmed paired-end FASTQ files from Trim Galore output
#   2. Run Bowtie2 with 15 threads against mm10 index
#   3. Pipe SAM → sorted BAM via samtools (15 threads each for view and sort)
#   4. Save Bowtie2 alignment stats to *_bowtie2_stats.txt
#
# INPUT:
#   conditions_chipdiffs.txt                    : File with one sample prefix per line
#   ./diff_chips_trimmed_fq_46/                 : Directory with Trim Galore output
#     ${LL}-R1_val_1.fq.gz                       : Read 1 (trimmed, validated)
#     ${LL}-R2_val_2.fq.gz                       : Read 2 (trimmed, validated)
#
# OUTPUT:
#   ./diff_chips_bams_46/${LL}_sorted.bam        : Coordinate-sorted alignments
#   ./diff_chips_bams_46/${LL}_bowtie2_stats.txt : Bowtie2 alignment report
#
# KEY PARAMETERS:
#   bowtie2 -p 15   : 15 CPU threads for alignment
#   samtools -@ 15  : 15 threads for view/sort operations
#   -x ./mm10/mm10  : Mouse mm10 genome index prefix
#
# DEPENDENCIES: bowtie2, samtools, mm10 index at ./mm10/mm10

# --- Bowtie2 automation for ChIP-seq differential analysis ---
while read -r LL; do
	L1=./diff_chips_trimmed_fq_46/${LL}-R1_val_1.fq.gz
	L2=./diff_chips_trimmed_fq_46/${LL}-R2_val_2.fq.gz
	BAM="./diff_chips_bams_46/${LL}_sorted.bam"
	bowtie2 "-p 15 -x ./mm10/mm10  -1 $L1 -2 $L2" 2>./diff_chips_bams_46/${LL}_bowtie2_stats.txt | samtools view -bS -@ 15 - | samtools sort -@ 15 >$BAM
done <conditions_chipdiffs.txt
