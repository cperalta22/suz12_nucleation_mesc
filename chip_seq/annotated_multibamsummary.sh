#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Runs deepTools multiBamSummary to compute genome-wide coverage
#          summaries across multiple BAM files. These NPZ matrices are used
#          downstream for PCA, correlation heatmaps, and sample clustering.
#
# WORKFLOW:
#   Runs multiBamSummary in 'bins' mode for several experimental groups:
#     - GFP (alone and with H3 background)
#     - H3 (alone)
#     - K27 (alone and with H3 background) [commented out]
#     - UB (alone and with H3 background)
#
#   Each group is run twice:
#     1. With --ignoreDuplicates (PCR duplicate removal)
#     2. Without duplicate removal (raw coverage)
#
# INPUT:
#   ./bams_sorted_1/*.bam    : Sorted BAM files, selected by glob pattern
#
# OUTPUT:
#   ../multibamsummary_results_2/mbs_<group>_nodups.npz          : Summary with dedup
#   ../multibamsummary_results_2/mbs_<group>.npz                 : Summary without dedup
#   ../multibamsummary_results_2/mbs_<group>_nodups_factors.tsv  : Scaling factors
#   ../multibamsummary_results_2/mbs_<group>_factors.tsv         : Scaling factors
#
# KEY PARAMETERS:
#   bins                     : Genome divided into fixed-size bins (default 10kb)
#   -p 25                    : 25 CPU threads
#   -v                       : Verbose output
#   --ignoreDuplicates       : Skip reads marked as PCR duplicates
#   --scalingFactors         : Output per-sample scaling factors for normalization
#
# ACTIVE GROUPS (uncommented lines):
#   UB alone + UB with H3 background + GFP with H3 background
#
# COMMENTED GROUPS (not currently run):
#   GFP alone, H3 alone, K27 alone, K27 + H3 background
#
# DEPENDENCIES: deepTools (multiBamSummary)

cd bams_sorted_1

# =========================================================================
# PER-MARK GROUP SUMMARIES
# =========================================================================

# --- UB (Ubiquitin/H2Aub) mark ---
multiBamSummary bins -p 25 -v  --ignoreDuplicates --bamfiles *UB*bam -o ../multibamsummary_results_2/mbs_UB_nodups.npz --scalingFactors ../multibamsummary_results_2/mbs_UB_nodups_factors.tsv
multiBamSummary bins -p 25 -v  --bamfiles *UB*bam -o ../multibamsummary_results_2/mbs_UB.npz --scalingFactors ../multibamsummary_results_2/mbs_UB_factors.tsv

# =========================================================================
# CO-ANALYSIS WITH H3 BACKGROUND
# =========================================================================
# H3 is used as a normalization/background reference for histone marks

# --- GFP + H3 co-analysis ---
multiBamSummary bins -p 25 -v  --ignoreDuplicates --bamfiles *GFP*bam *H3*bam -o ../multibamsummary_results_2/mbs_GFP_h3background_nodups.npz --scalingFactors ../multibamsummary_results_2/mbs_GFP_h3background_nodups_factors.tsv
multiBamSummary bins -p 25 -v  --bamfiles *GFP*bam *H3*bam -o ../multibamsummary_results_2/mbs_GFP_h3background.npz --scalingFactors ../multibamsummary_results_2/mbs_GFP_h3background_factors.tsv

# --- UB + H3 co-analysis ---
multiBamSummary bins -p 25 -v  --ignoreDuplicates --bamfiles *UB*bam *H3*bam -o ../multibamsummary_results_2/mbs_UB_h3background_nodups.npz --scalingFactors ../multibamsummary_results_2/mbs_UB_h3background_nodups_factors.tsv
multiBamSummary bins -p 25 -v  --bamfiles *UB*bam *H3*bam -o ../multibamsummary_results_2/mbs_UB_h3background.npz --scalingFactors ../multibamsummary_results_2/mbs_UB_h3background_factors.tsv
