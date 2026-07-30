#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Batch indexing of BAM files for rapid random access in downstream
#          tools (genome browsers, deepTools, IGV, etc.).
#
# WORKFLOW:
#   1. Changes to the target BAM directory
#   2. Iterates over all *.bam files
#   3. Runs samtools index with 20 threads, producing .bam.bai index files
#
# KEY PARAMETERS:
#   samtools index -@ 20 : 20 CPU threads for index construction
#
# INPUT:
#   ./bams_merged_for_heatmaps_6/*.bam  : Coordinate-sorted BAM files
#
# OUTPUT:
#   ./bams_merged_for_heatmaps_6/*.bam.bai  : BAM index files
#
# NOTES:
#   - The original directory was ./bams_sorted_1/ and was switched to
#     bams_merged_for_heatmaps_6/. Adjust as needed.
#
# DEPENDENCIES: samtools

cd ./bams_merged_for_heatmaps_6

for f in *bam
do
  BAI="${f}.bai"
  samtools index -@ 20  ${f} -o ${BAI}
done
