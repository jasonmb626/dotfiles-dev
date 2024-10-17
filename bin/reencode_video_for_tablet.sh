#!/bin/sh

file_to_reencode=$1

if [[ "$file_to_reencode" == "" ]]; then
  echo "Error: missing filename."
  exit
fi

if [[ ! -s $file_to_reencode ]]; then
  echo "Error: $file_to_reencode does not exist or is empty."
  exit
fi

probe_info=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height "$file_to_reencode")

orig_height=$(echo "$probe_info" | grep 'height=' | awk -F= '{print $2}')
orig_width=$(echo "$probe_info" | grep 'width=' | awk -F= '{print $2}')
ratio=$(echo "scale=4; $orig_width / $orig_height" | bc)
echo "orig width $orig_width height $orig_height ratio $ratio" >>conv.log

new_height=720
new_width=$(echo "scale=0; $new_height * $ratio / 1" | bc)

echo "new_width $new_width new_height $new_height" >>conv.log

threshold=0
ideal_ratio=$(echo "scale=4; 1080 / $new_height" | bc)
diff=$(echo "$ideal_ratio - $ratio" | bc)
diff="${diff/#-}"

if [[ $(echo "$diff < .3" | bc) -eq 1  ]]; then
    padded_width=1280
else
    padded_height=720
fi
echo "Padded width: $padded_width" >> conv.log

pad_offset=0
diff=$((padded_width - new_width))
if [[ $diff -gt 2 ]]; then
    pad_offset=$((diff /2))
fi

new_filename=$(echo "$file_to_reencode" | sed -r 's/(.*)(.mp4|.mkv|.webm|.avi)$/\1.mp4/')
echo "$new_filename" >>conv.log

cmd="ffmpeg -y -i \"$file_to_reencode\" -c:v h264 -c:a aac -ac 2 -r 30 -vf scale=$padded_width:$new_height \"conv/$new_filename\""
if [[ $pad_offset -ne 0 ]]; then
  cmd="ffmpeg -y -i \"$file_to_reencode\" -c:v h264 -c:a aac -ac 2 -r 30 -vf scale=$new_width:$new_height,pad=$padded_width:$new_height:0:$pad_offset  \"conv/$new_filename\""
fi

if [[ ! -d conv ]]; then
    mkdir conv
fi
echo "Running $cmd" >>conv.log

if [[ "$2" != "--dry-run" ]]; then
    eval $cmd
fi
