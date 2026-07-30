#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# PURPOSE: Computes the average genomic distance spanned by chromatin
#          interaction loops from a tabular file with paired anchor coordinates.
#
# INPUT: completee_H3K27me3_10Kb_loops_with_NSs.tabular
#   Expected format: two sets of coordinates per line representing
#   the two anchors of a chromatin loop. The script uses columns 2,3
#   (first anchor start/end) and columns 11,12 (second anchor start/end).
#
# ALGORITHM:
#   For each loop, compute the total span as:
#     distance = max(end1, end2) - min(start1, start2)
#   Then compute the arithmetic mean across all loops.
#
# OUTPUT: "Average distance: <value>" or "No valid interactions found"
#
# DEPENDENCIES: awk (POSIX)

awk '{
    # Determine the leftmost start and rightmost end across both anchors
    start = $2 < $11 ? $2 : $11
    end = $3 > $12 ? $3 : $12
    distance = end - start
    sum += distance
    count++
}
END {
    if (count > 0)
        printf "Average distance: %.2f\n", sum/count
    else
        print "No valid interactions found"
}' completee_H3K27me3_10Kb_loops_with_NSs.tabular
