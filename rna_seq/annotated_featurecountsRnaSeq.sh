#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Runs featureCounts (from the Subread package) on all BAM files
#          in a directory to generate per-sample gene-level count tables
#          for RNA-seq differential expression analysis.
#
# WORKFLOW:
#   1. Iterates over all *.bam files in BAMDIR
#   2. Strips the _sorted.bam suffix and BAMDIR prefix to get the sample name
#   3. Runs featureCounts with paired-end mode, 25 threads, against mm10
#      gene annotations (GTF)
#
# KEY PARAMETERS:
#   -p              : Paired-end mode; fragments (not reads) are counted
#   -T 25           : 25 CPU threads
#   -t exon         : Feature type to count (exons in the GTF)
#   -g gene_id      : Attribute to group features by (gene-level summarization)
#   -a ./mm10.gtf   : Annotation file (mouse mm10 genome)
#   -o ${OUTFILE}   : Output count table
#
# INPUT:
#   ./bams/*.bam              : Coordinate-sorted BAM files
#   ./mm10.gtf                : Gene annotations in GTF format
#
# OUTPUT:
#   ./featurecounts/${SAMPLE}_counts.txt : Per-sample gene count table
#
# NOTES:
#   - If BAMDIR is changed, the sed pattern on line 9 must also be updated
#     to correctly strip the directory prefix from the sample name.
#
# DEPENDENCIES: Subread (featureCounts), mm10 GTF annotation

BAMDIR="./bams/" # IF CHANGED, REPLACE SED PATTERN BELOW
OUTDIR="./featurecounts/"
COUNTSID="_counts.txt"

for BAM in ${BAMDIR}*bam; do
	SAMPLE=$(echo ${BAM/_sorted.bam/} | sed 's/.\/bams\///') # PATTERN MUST CHANGE IF BAMDIR CHANGES
	OUTFILE="${OUTDIR}${SAMPLE}${COUNTSID}"
	featureCounts -p -T 25 -t exon -g gene_id -a ./mm10.gtf -o "${OUTFILE}" "${BAM}"
done
