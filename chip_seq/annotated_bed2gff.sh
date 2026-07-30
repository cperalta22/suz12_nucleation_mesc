#!/usr/bin/bash
# =============================================================================
# Partially or fully annotated by a DeepSeek-v4-pro powered agent.
# Human comments translated by the same agent.
# =============================================================================
#
# TITLE:    BED to GFF Converter
# AUTHOR:   Carlos Peralta — Instituto de Fisiología Celular, UNAM
# LICENSE:  GPLv3
#
# PURPOSE: Converts BED files (Browser Extensible Data) to GFF (General
#          Feature Format). Assumes the BED file contains a single feature
#          type. The GFF type column (col 3) defaults to "peak" and the
#          attributes column (col 9) is populated with a unique consecutive
#          "Peak" identifier plus a "bedID" taken from the BED name column
#          (col 4) when available.
#
# BED INPUT REQUIREMENTS:
#   - Minimum 3 columns (chrom, start, end)
#   - Columns 4-6 optional (name, score, strand); if col 5 or 6 is needed,
#     all previous columns must be present
#   - Only first 6 BED columns are used; extra columns are discarded
#
# OPTIONS:
#   -i <file>   : Input BED file (required)
#   -x           : Ignore columns 4-6 (use only chrom/start/end)
#   -t <string>  : GFF type column value (default: "peak")
#   -f <string>  : GFF feature column value (default: "peak")
#   -h           : Show help message
#
# USAGE:
#   bed2gff.sh -i input.bed > output.gff
#
# INTERNAL WORKFLOW:
#   The script operates by replacing tab characters with '%' as an
#   internal delimiter (avoiding awk field-splitting complexity), then
#   uses cut, seq, sed, and paste to assemble GFF columns. Mode selection
#   (3, 4, 5, or 6 columns) determines which GFF fields are populated
#   from BED data vs. filled with placeholders.
#
# DEPENDENCIES: POSIX shell, coreutils (cat, cut, sed, seq, paste, wc, tr, tput)

# --- Terminal color definitions for stdout/stderr ---
error=`tput setaf 1`
info=`tput setaf 2`
warn=`tput setaf 3`
colorbg=`tput setab 1`
reset=`tput sgr0`
noinfo=false
typeg="peak"
featureg="peak"
mode=0

# --- Argument parsing ---
while getopts i:xt:f:h flag
do
    case $flag in
	i) inputfile=$OPTARG;;
	x) noinfo=true;;
	t) typeg=$OPTARG;;
	f) featureg=$OPTARG;;
	h) >&2 echo
	   >&2 echo "${warn}BED to GFF Converter: ${reset}"
     >&2 echo ""
     >&2 echo "Basic usage:"
	   >&2 echo "${info}bed2gff.sh -i[[input bed file]] > [[output GFF]]${reset}"
     >&2 echo ""
     >&2 echo "Additional options"
	   >&2 echo "${info}-x ---- Ignore 4th through 6th BED file columns${reset}"
     >&2 echo "${info}-t ---- Type column information (default: peak)${reset}"
     >&2 echo "${info}-f ---- Feature column information (default: peak)${reset}"
	   >&2 echo "${info}-h ---- Show this message${reset}"
	   >&2 echo
	   exit;;
  *) >&2 echo "${error}Run bed2gtf.sh -h for help"
     exit;;
    esac
done

# --- Input validation: require -i flag ---
if [ -z $inputfile ];
  then
    >&2 echo "${error}ERROR: This script requires an input file"
    >&2 echo ""
    >&2 echo "    ${info}bed2gff -i [[input bed file]] > [[output GFF]]"
    >&2 echo ''
    >&2 echo "${error}Run bed2gtf.sh -h for help"
    exit
elif [ -f $inputfile ];
  then
     >&2 echo "${info}File exists"
    # Replace tabs with '%' as internal field delimiter
    cat $inputfile | sed -e 's/\t/%/g' > bed.b2g
    colcount=$(head -1 bed.b2g | tr -cd "%" | wc -c)
    if [ $colcount -lt 2 ]; then
      >&2 echo "${error}Error: $(($colcount+1)) columns detected; 3 is the minimum required"
      rm bed.b2g
      exit
    elif [[ $noinfo == true ]]; then
      >&2 echo "${error}$(($colcount+1)) columns detected: But -x argument was passed, only first 3 columns will be used"
      mode=3
    elif [ $colcount -gt 5 ]; then
      >&2 echo "${warn}$(($colcount+1)) columns detected: only the first 6 columns will be used"
      mode=6
    else
      >&2 echo "${info}$(($colcount+1)) columns detected"
      mode=$(($colcount+1))
    fi
else
    >&2 echo "${error}ERROR: Input file does not exist, check spelling/path"
    >&2 echo ""
    >&2 echo "${error}Run bed2gtf.sh -h for help"
    exit
fi

# =========================================================================
# INTERNAL FUNCTIONS — executed according to the selected mode
# =========================================================================

# --- coreParsing: Extracts seqid, start, end, source, phase, type, attributes ---
# Called in all modes. Builds the invariant GFF columns.
coreParsing(){
  cut -d % -f 1 bed.b2g > seqid.b2g
  cut -d % -f 2 bed.b2g > start.b2g
  cut -d % -f 3 bed.b2g > end.b2g
  seq $(wc -l bed.b2g | cut -f 1 -d ' ') | sed -e 's/.*/bed2gff.sh/'  > source.b2g
  seq $(wc -l bed.b2g | cut -f 1 -d ' ') | sed -e 's/.*/\./'  > phase.b2g
  seq $(wc -l bed.b2g | cut -f 1 -d ' ') | sed -e "s/.*/$typeg/"  > type.b2g
  seq $(wc -l bed.b2g | cut -f 1 -d ' ') | sed -e "s/^/$featureg p-/" | sed -e 's/$/;/' > attributes.b2g
}

# --- makeStrand: Fills strand column with '.' placeholder (modes 3, 4, 5) ---
makeStrand(){
  seq $(wc -l bed.b2g | cut -f 1 -d ' ') | sed -e 's/.*/\./'  > strand.b2g
}

# --- makeScore: Fills score column with '.' placeholder (modes 3, 4, 5, 6) ---
makeScore(){
  seq $(wc -l bed.b2g | cut -f 1 -d ' ') | sed -e 's/.*/\./'  > score.b2g
}

# --- keepNames: Preserves BED name column (col 4) as GFF bedID attribute (modes 4, 5, 6) ---
keepNames(){
  cut -d % -f 4 bed.b2g > bedNames.b2g
  mv attributes.b2g oldatt.b2g
  sed -ie 's/$/bedID /' oldatt.b2g
  paste -d '' oldatt.b2g bedNames.b2g | sed -e 's/$/;/' > attributes.b2g
}

# --- copyStrand: Copies BED strand column (col 6) to GFF (mode 6) ---
copyStrand(){
  cut -d % -f 6 bed.b2g > strand.b2g
}

# --- copyScore: Copies BED score column (col 5) to GFF (modes 5, 6) ---
copyScore(){
  cut -d % -f 5 bed.b2g > score.b2g
}

# --- buildGFF: Assembles all column files into final GFF, cleans temporary files ---
buildGFF(){
  paste seqid.b2g source.b2g type.b2g start.b2g end.b2g score.b2g strand.b2g phase.b2g attributes.b2g
  rm *.b2g*
  >&2 echo "${warn}Success!"
}

# =========================================================================
# MODE DISPATCH — executes the appropriate function chain
# =========================================================================
if [ $mode == 0 ]; then
  >&2 echo "${error} ERROR: Something went wrong, sorry"
  rm *.b2g*
  exit
elif [ $mode == 3 ]; then
  coreParsing
  makeScore
  makeStrand
  buildGFF
elif [ $mode == 4 ]; then
  coreParsing
  keepNames
  makeScore
  makeStrand
  buildGFF
elif [ $mode == 5 ]; then
  coreParsing
  keepNames
  copyScore
  makeStrand
  buildGFF
elif [ $mode == 6 ]; then
  coreParsing
  keepNames
  copyScore
  copyStrand
  buildGFF
fi
