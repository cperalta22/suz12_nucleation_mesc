#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Automated Bowtie2 alignment pipeline for RNA-seq paired-end reads.
#          Aligns trimmed reads to the mouse genome (mm10), converts SAM to
#          sorted BAM in a single pipe.
#
# WORKFLOW (per sample, read from 'prefixes' file):
#   1. Locate trimmed paired-end FASTQ files (R1 and R2) from Trim Galore output
#   2. Run Bowtie2 with 20 threads against mm10 index
#   3. Pipe SAM → sorted BAM via samtools (15 threads each for view and sort)
#   4. Save Bowtie2 alignment stats to *_bowtie2_stats.txt
#
# INPUT:
#   prefixes              : File with one sample prefix per line
#   ./trimgalore/         : Directory with Trim Galore output
#     ${LL}_R1_val_1.fq.gz : Read 1 (trimmed, validated)
#     ${LL}_R2_val_2.fq.gz : Read 2 (trimmed, validated)
#
# OUTPUT:
#   ./bams/${LL}_sorted.bam              : Coordinate-sorted alignments
#   ./bams/${LL}_bowtie2_stats.txt       : Bowtie2 alignment report (stderr)
#
# KEY PARAMETERS:
#   bowtie2 -p 20   : 20 CPU threads for alignment
#   samtools -@ 15  : 15 threads for view/sort operations
#   -x ./mm10/mm10  : Mouse mm10 genome index prefix
#
# DEPENDENCIES: bowtie2, samtools, mm10 index at ./mm10/mm10

# --- Bowtie2 automation ---
while read -r LL; do
	L1=./trimgalore/${LL}_R1_val_1.fq.gz
	L2=./trimgalore/${LL}_R2_val_2.fq.gz
	BAM="./bams/${LL}_sorted.bam"
	ls $L1
	ls $L2
	echo $BAM
	bowtie2 "-p 20 -x ./mm10/mm10  -1 $L1 -2 $L2" 2>./bams/${LL}_bowtie2_stats.txt | samtools view -bS -@ 15 - | samtools sort -@ 15 >$BAM
done <prefixes
