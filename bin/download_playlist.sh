#!/bin/sh

url=$1

if [[ "$url" == "" ]]; then
  echo "Missing URL."
  exit
fi

yt-dlp -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" --restrict-filenames -f "299+251" "$url"
