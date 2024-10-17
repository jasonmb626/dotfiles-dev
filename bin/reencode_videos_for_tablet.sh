#!/bin/sh

for filename in *; do
  case $filename in
    *.mp4|*.avi|*.mkv|*.webm)
      reencode_video_for_tablet.sh "$filename" $1 #pass --dry-run to this script in order to also pass that along to the script
  esac
done


