#!/bin/sh

set -u

#USAGE: combine_audio "<outfilename>" glob
#

if [[ "$1" == "-t" ]]; then
    filetype=$2
    shift
    shift
else
    filetype="mp3"
fi

outname="$1.$filetype"
shift
args=("$@")
IFS=$'\n'

echo "$(printf '%q\n' ${args[*]} | sed 's/\\/\\\\/g')"
inputs=$(printf '%q\n' ${args[*]} | sed 's/\\/\\\\/g' | xargs -I {} echo -i {} | sed 's/\\/\\\\/g' | xargs)
inputs=$(printf '%q\0' ${args[*]} | xargs -0 -I {} printf "-i %s\0" {} | xargs -0)

map_str="$(echo "$(seq 0 $(($# - 1)))" | xargs -I {} echo "[{}:a:0]" | xargs | sed 's/ //g')"

cmd="ffmpeg $inputs -filter_complex \"${map_str}concat=n=$#:v=0:a=1[outa]\" -map \"[outa]\" -c:a $filetype \"$outname\""
echo "$cmd"
eval $cmd
