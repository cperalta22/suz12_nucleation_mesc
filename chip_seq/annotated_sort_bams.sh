#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Batch coordinate-sorting of BAM files. Reads unsorted BAMs from
#          ./bams_new/, sorts them with 20 threads, and writes to
#          ../bams_sorted_1/ with _sorted.bam suffix.
#
# WORKFLOW:
#   1. Changes to ./bams_new/ directory
#   2. For each *.bam file, runs samtools sort
#   3. Strips .bam extension and appends _sorted.bam for the output name
#   4. Writes sorted BAM to ../bams_sorted_1/
#
# KEY PARAMETERS:
#   samtools sort -@ 20 : 20 CPU threads for sorting
#
# INPUT:
#   ./bams_new/*.bam     : Unsorted (or name-sorted) BAM files
#
# OUTPUT:
#   ../bams_sorted_1/<sample>_sorted.bam : Coordinate-sorted BAM files
#
# DEPENDENCIES: samtools

cd ./bams_new
for f in *bam
do
  BAM="../bams_sorted_1/${f%.bam}_sorted.bam"
  samtools sort  -@ 20  "$f" > $BAM
done
