#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Copies processed bigWig coverage tracks for ChIP-seq samples
#          to a submission-ready directory. These are the final normalized
#          coverage files suitable for genome browser upload or GEO
#          deposition.
#
# EXPERIMENTAL DESIGN:
#   Three conditions × two histone marks × 2 replicates:
#
#   Condition         | GFP Mark              | K27 Mark
#   ------------------|-----------------------|------------------------
#   Mock (control)    | Mock_GFP-{1,2}.bw     | Mock_K27-{1,2}.bw
#   Auxin (degron)    | Auxin_GFP-{1,2}.bw    | Auxin_K27-{1,2}.bw
#   SimpleRescue      | SimpleRescue_GFP-{1,2}.bw | SimpleRescue_K27-{1,2}.bw
#
# SOURCE:
#   /hdd/Itzel/NuevoTodo/bw_files_4/GFP/   — GFP bigWig tracks
#   /hdd/Itzel/NuevoTodo/bw_files_4/K27/   — K27 bigWig tracks
#
# OUTPUT:
#   Current directory — 12 bigWig files ready for submission/deposition

# --- GFP bigWig tracks ---
cp /hdd/Itzel/NuevoTodo/bw_files_4/GFP/Mock_GFP-1.bw .
cp /hdd/Itzel/NuevoTodo/bw_files_4/GFP/Mock_GFP-2.bw .
cp /hdd/Itzel/NuevoTodo/bw_files_4/GFP/Auxin_GFP-1.bw .
cp /hdd/Itzel/NuevoTodo/bw_files_4/GFP/Auxin_GFP-2.bw .
cp /hdd/Itzel/NuevoTodo/bw_files_4/GFP/SimpleRescue_GFP-1.bw .
cp /hdd/Itzel/NuevoTodo/bw_files_4/GFP/SimpleRescue_GFP-2.bw .

# --- K27 bigWig tracks ---
cp /hdd/Itzel/NuevoTodo/bw_files_4/K27/Mock_K27-1.bw .
cp /hdd/Itzel/NuevoTodo/bw_files_4/K27/Mock_K27-2.bw .
cp /hdd/Itzel/NuevoTodo/bw_files_4/K27/Auxin_K27-1.bw .
cp /hdd/Itzel/NuevoTodo/bw_files_4/K27/Auxin_K27-2.bw .
cp /hdd/Itzel/NuevoTodo/bw_files_4/K27/SimpleRescue_K27-1.bw .
cp /hdd/Itzel/NuevoTodo/bw_files_4/K27/SimpleRescue_K27-2.bw .
