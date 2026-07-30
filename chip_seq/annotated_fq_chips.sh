#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Copies trimmed ChIP-seq FASTQ files from the main analysis
#          directory to a submission-ready directory with standardized
#          human-readable names. This prepares data for deposition in
#          public repositories (e.g., GEO, ENA).
#
# WORKFLOW:
#   Each line copies one FASTQ file from the Trim Galore output directory
#   and renames it to a descriptive format:
#     <Condition>_<Mark>-<Replicate>_val_R<1|2>.fq.gz
#
# EXPERIMENTAL DESIGN:
#   Three conditions × two histone marks × 2 replicates:
#
#   Condition         | GFP Mark              | K27 Mark
#   ------------------|-----------------------|------------------------
#   Mock (control)    | Mock_GFP-{1,2}        | Mock_K27-{1,2}
#   Auxin (degron)    | Auxin_GFP-{1,2}       | Auxin_K27-{1,2}
#   SimpleRescue      | SimpleRescue_GFP-{1,2}| SimpleRescue_K27-{1,2}
#
#   Ale7-Ale18 are internal sample identifiers from the sequencing core.
#
# SOURCE:
#   /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/
#
# OUTPUT:
#   Current directory — renamed FASTQ files ready for submission

# --- GFP — Mock condition ---
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale15_simple_1_val_1.fq.gz Mock_GFP-1_val_R1.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale16_simple_1_val_1.fq.gz Mock_GFP-2_val_R1.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale15_simple_2_val_2.fq.gz Mock_GFP-1_val_R2.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale16_simple_2_val_2.fq.gz Mock_GFP-2_val_R2.fq.gz

# --- GFP — Auxin condition ---
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale13_simple_1_val_1.fq.gz Auxin_GFP-1_val_R1.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale14_simple_1_val_1.fq.gz Auxin_GFP-2_val_R1.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale13_simple_2_val_2.fq.gz Auxin_GFP-1_val_R2.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale14_simple_2_val_2.fq.gz Auxin_GFP-2_val_R2.fq.gz

# --- GFP — SimpleRescue condition ---
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale17_simple_1_val_1.fq.gz SimpleRescue_GFP-1_val_R1.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale18_simple_1_val_1.fq.gz SimpleRescue_GFP-2_val_R1.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale17_simple_2_val_2.fq.gz SimpleRescue_GFP-1_val_R2.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale18_simple_2_val_2.fq.gz SimpleRescue_GFP-2_val_R2.fq.gz

# --- K27 — Mock condition ---
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale7_simple_1_val_1.fq.gz Mock_K27-1_val_R1.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale7_simple_2_val_2.fq.gz Mock_K27-1_val_R2.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale8_simple_1_val_1.fq.gz Mock_K27-2_val_R1.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale8_simple_2_val_2.fq.gz Mock_K27-2_val_R2.fq.gz

# --- K27 — Auxin condition ---
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale10_simple_1_val_1.fq.gz Auxin_K27-2_val_R1.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale10_simple_2_val_2.fq.gz Auxin_K27-2_val_R2.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale9_simple_1_val_1.fq.gz Auxin_K27-1_val_R1.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale9_simple_2_val_2.fq.gz Auxin_K27-1_val_R2.fq.gz

# --- K27 — SimpleRescue condition ---
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale11_simple_1_val_1.fq.gz SimpleRescue_K27-1_val_R1.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale12_simple_1_val_1.fq.gz SimpleRescue_K27-2_val_R1.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale11_simple_2_val_2.fq.gz SimpleRescue_K27-1_val_R2.fq.gz
cp /hdd/Itzel/chip-seq_abril_2024/cpaWork/fastq/trimgalore/Ale12_simple_2_val_2.fq.gz SimpleRescue_K27-2_val_R2.fq.gz
