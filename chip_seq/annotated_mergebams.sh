#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Merges groups of BAM files based on experimental condition
#          definitions. Reads sample group assignments from a text file
#          and uses samtools merge to combine replicates.
#
# WORKFLOW:
#   1. Reads condition definitions from ../peaks_conditions.txt
#   2. Each line is a glob pattern matching replicate BAMs (e.g., "Mock_GFP-*_sorted.bam")
#   3. Strips the glob suffix to derive the merged BAM name
#   4. Runs samtools merge with 25 threads
#
# INPUT:
#   ../peaks_conditions.txt      : One glob pattern per line (matching replicate BAMs)
#   ./bams_sorted_1/*.bam        : Individual replicate BAM files
#
# OUTPUT:
#   /hdd/Itzel/NuevoTodo/bams_merged_for_heatmaps_6/<condition>_merged.bam
#
# KEY PARAMETERS:
#   samtools merge -@ 25  : 25 threads for merge operation
#
# NOTES:
#   - The glob pattern is matched in the current directory (./bams_sorted_1/)
#   - The merged BAM is written to a separate directory on /hdd/
#
# DEPENDENCIES: samtools

MPATH="/hdd/Itzel/NuevoTodo/bams_merged_for_heatmaps_6/"

cd /hdd/Itzel/NuevoTodo/bams_sorted_1/

# --- Merge replicates per condition ---
while read -r LL
do
  MBAM="${MPATH}${LL%-*}_merged.bam"
  samtools merge -@ 25 -o "${MBAM}" ${LL}
done < ../peaks_conditions.txt
