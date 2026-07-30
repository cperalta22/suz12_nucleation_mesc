#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Batch generation of bigWig coverage tracks from BAM files using
#          deepTools bamCoverage. Reads sample-to-normalization mappings
#          from CSV files and produces normalized bigWig files for genome
#          browser visualization.
#
# WORKFLOW:
#   1. Iterates over CSV files in bw_create_3/ directory
#   2. Each CSV line contains: BAM_filename,normalization_factor
#   3. Runs bamCoverage with read extension, 5bp bin size, and the
#      specified scale factor
#   4. Outputs to organized subdirectories under BWPATH
#
# INPUT:
#   bw_create_3/*.csv          : CSV files mapping BAM names to scale factors
#     Format: <bam_filename>,<normalization_factor>
#   BAMPATH/*.bam              : Sorted BAM files (source for coverage)
#
# OUTPUT:
#   BWPATH/<csv_name>/         : Per-experiment bigWig files
#
# KEY PARAMETERS:
#   --scaleFactor <NORM>   : Normalization factor (e.g., 1/scale factor from DESeq2)
#   --extendReads           : Extend reads to fragment size (ChIP-seq standard)
#   --binSize 5             : 5 bp bin size for high-resolution coverage
#   -p 25                   : 25 CPU threads
#   -v                      : Verbose output
#
# DEPENDENCIES: deepTools (bamCoverage), samtools-indexed BAM files

BAMPATH="/hdd/Itzel/NuevoTodo/bams_sorted_1/"
BWPATH="/hdd/Itzel/NuevoTodo/bw_files_4/"

cd bw_create_3

# --- Process each CSV configuration file ---
for CSV in *
do
  echo PROCESSING ${CSV}
  RESPATH="${BWPATH}${CSV}/"
  [ -d ${RESPATH} ] || mkdir ${RESPATH}
  while read -r LL
  do
    # Parse BAM filename and normalization factor from CSV
    BAM=${BAMPATH}$(echo "${LL}" | cut -f 1 -d ',')
    BW=${RESPATH}$(echo "${LL/_sorted.bam/.bw}" | cut -f 1 -d ',')
    NORM=$( echo "${LL}" | cut -f 2 -d ',')

    # Generate bigWig with per-sample normalization
    bamCoverage -b "${BAM}" --outFileName "${BW}" --outFileFormat bigwig --scaleFactor "${NORM}" -p 25 -v --extendReads --binSize 5
  done < ${CSV}
  echo "----------------------------------------------"
done
