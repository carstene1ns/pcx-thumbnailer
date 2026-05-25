#!/bin/bash

# Copyright (c) 2015-2026 carstene1ns <dev@f4ke.de>
# This file is released under the MIT License
# http://opensource.org/licenses/MIT

# enable for debugging
#set -x

# helper functions
function error_out {
	echo $1
	exit 1
}

# check arguments
[ $# -lt 2 -o $# -gt 3 ] && \
	error_out "Usage: pcx-thumbnailer path/to/input.pcx path/to/output.png [size in pixels]"

INPUT=$1
OUTPUT=$2
SIZE=${3:-128}

[ -s "${INPUT}" ] || error_out "Input file not found!"

INPUTLC=${INPUT,,}
[ "${INPUTLC}" == "${INPUTLC%.pcx}" ] && \
	echo "Input file has not PCX extension, continuing anyway!" >&2

[[ ${SIZE} == +([0-9]) ]] || \
	error_out "Size argument is not a valid number!"
PIXELCOUNT=$((${SIZE}*${SIZE}))

OUTPUTFOLDER=$(dirname "${OUTPUT}")
if [ ! -d "$OUTPUTFOLDER" ]; then
	echo "Output folder does not exist, creating it!" >&2
	mkdir -p "$OUTPUTFOLDER"
fi

# convert!
magick ${INPUT} -thumbnail ${PIXELCOUNT}@ \
	-gravity center -background transparent \
	-extent ${SIZE}x${SIZE} PNG:${OUTPUT}

[ -s ${OUTPUT} ] || error_out "Could not convert to thumbnail!"

# all good
exit 0
