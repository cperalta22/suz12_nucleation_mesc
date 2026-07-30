#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Extracts unique peak names from multiple BED/TSV peak files,
#          merges overlapping peaks, assigns random unique identifiers,
#          and annotates peaks against anchor and nucleation regions.
#
# WORKFLOW:
#   1. Concatenate all *.tsv peak files into a single BED file
#   2. Sort and merge overlapping intervals with bedtools
#   3. Assign unique random names via makeNames.sh
#   4. Annotate merged peaks against anchor regions (mergedA1_2.tsv)
#   5. Annotate merged peaks against nucleation regions (bienPortadosDeseq_GFP.tsv)
#
# SANITY CHECK:
#   The script prints the total peak count vs. unique name count.
#   These MUST be equal before proceeding. If they differ, re-run until
#   makeNames.sh produces all-unique names (collision resolution).
#
# DEPENDENCIES: bedtools, makeNames.sh (same directory)

# --- Step 1: Concatenate all peak files ---
# CHANGE THIS LINE for different input patterns
cat *tsv > allpeaks

# --- Step 2: Sort and merge overlapping peaks ---
# DO NOT CHANGE — core merge logic
bedtools sort -i allpeaks | bedtools merge > allmergedpeaks
numeropicos=$(wc -l allmergedpeaks | cut -f 1 -d " ")
bash makeNames.sh $numeropicos
paste allmergedpeaks archivo.txt > picosconnombre.bed
nombresunicos=$(cat archivo.txt | sort | uniq | wc -l)
echo
echo "DO NOT PROCEED IF THE FOLLOWING TWO NUMBERS ARE NOT EQUAL"
echo "Total peak count:"
echo $numeropicos
echo
echo "Unique name count:"
echo $nombresunicos
echo
echo "IF THEY DIFFER, REPEAT UNTIL THEY MATCH"

# --- Step 3: Annotate peaks against anchor regions ---
# bedtools annotate -counts -i picosconnombre.bed -files {CHANGE_ME} | grep -vE "0$" | cut -f 4 > {CHANGE_ME}
bedtools annotate -counts -i picosconnombre.bed -files mergedA1_2.tsv | grep -vE "0$" | cut -f 4 > picosAnchors

# --- Step 4: Annotate peaks against nucleation regions ---
bedtools annotate -counts -i picosconnombre.bed -files bienPortadosDeseq_GFP.tsv | grep -vE "0$" | cut -f 4 > picosNucleation
