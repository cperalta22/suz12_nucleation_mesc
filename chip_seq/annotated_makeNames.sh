#!/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Generates a file of unique random alphanumeric identifiers for
#          assigning names to merged genomic peaks.
#
# USAGE: bash makeNames.sh <N>
#   N = number of unique names to generate (should equal total peak count)
#
# OUTPUT: archivo.txt — one 15-character random alphanumeric string per line
#
# MECHANISM:
#   Uses /dev/urandom to generate cryptographically-random bytes, filters to
#   alphanumeric characters (A-Za-z0-9), and takes the first 15 characters.
#   This produces collision-prone names for large N; the caller script
#   (getUniquePeakNamesByPeakFile.sh) validates uniqueness and re-runs if
#   collisions occur.
#
# PARAMETERS:
#   $1 (N) : Number of lines/identifiers to generate

N=$1  # Change this value to the number of lines needed
OUTPUT="archivo.txt"

> "$OUTPUT"  # Truncate output file if it already exists

for ((i = 0; i < N; i++)); do
  tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 15 >> "$OUTPUT"
  echo >> "$OUTPUT"
done
