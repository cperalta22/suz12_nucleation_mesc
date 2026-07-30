#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Copies RNA-seq FASTQ files and featureCounts output to a
#          submission-ready directory with standardized names. Prepares
#          raw reads and processed count tables for public repository
#          deposition (e.g., GEO).
#
# EXPERIMENTAL DESIGN:
#   Three conditions × 3 replicates:
#
#   Condition         | Replicates
#   ------------------|----------------------------------
#   Mock (control)    | mesc_mock_{1,2,3}_R{1,2}.fq.gz
#   Auxin (degron)    | mesc_aux_{1,2,3}_R{1,2}.fq.gz
#   Rescue            | mesc_res_{1,2,3}_R{1,2}.fq.gz
#
#   "mesc" = mouse embryonic stem cells
#
# FILES COPIED:
#   Part 1 — Trimmed FASTQ (18 files):
#     9 samples × 2 paired-end files (R1 + R2)
#
#   Part 2 — Gene count tables (8 files):
#     Per-sample featureCounts output (_counts.txt)
#     Note: mesc_res_3_counts.txt is not included (line 27 is the last)
#
# SOURCE:
#   /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/  — FASTQ files
#   /hdd/Itzel/mRNA-422336955/featurecounts/       — Count tables
#
# OUTPUT:
#   Current directory — FASTQ + count tables ready for submission

# =========================================================================
# TRIMMED FASTQ FILES (paired-end)
# =========================================================================

# --- Mock condition (3 replicates) ---
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_mock_1_R1.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_mock_1_R2.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_mock_2_R1.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_mock_2_R2.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_mock_3_R1.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_mock_3_R2.fq.gz .

# --- Auxin condition (3 replicates) ---
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_aux_1_R1.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_aux_1_R2.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_aux_2_R1.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_aux_2_R2.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_aux_3_R1.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_aux_3_R2.fq.gz .

# --- Rescue condition (3 replicates) ---
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_res_1_R1.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_res_1_R2.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_res_2_R1.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_res_2_R2.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_res_3_R1.fq.gz .
cp /hdd/Itzel/mRNA-422336955/rnaSeqSingleFiles/mesc_res_3_R2.fq.gz .

# =========================================================================
# GENE COUNT TABLES (featureCounts output)
# =========================================================================

# --- Mock counts ---
cp /hdd/Itzel/mRNA-422336955/featurecounts/mesc_mock_1_counts.txt .
cp /hdd/Itzel/mRNA-422336955/featurecounts/mesc_mock_2_counts.txt .
cp /hdd/Itzel/mRNA-422336955/featurecounts/mesc_mock_3_counts.txt .

# --- Auxin counts ---
cp /hdd/Itzel/mRNA-422336955/featurecounts/mesc_aux_1_counts.txt .
cp /hdd/Itzel/mRNA-422336955/featurecounts/mesc_aux_2_counts.txt .
cp /hdd/Itzel/mRNA-422336955/featurecounts/mesc_aux_3_counts.txt .

# --- Rescue counts (2 of 3 replicates; mesc_res_3 missing) ---
cp /hdd/Itzel/mRNA-422336955/featurecounts/mesc_res_1_counts.txt .
cp /hdd/Itzel/mRNA-422336955/featurecounts/mesc_res_2_counts.txt .
