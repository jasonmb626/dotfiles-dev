#!/usr/bin/env python3

import sys
import os
import subprocess
import glob

# Assumes playlist downloaded with this command
# yt-dlp -o "%(playlist)s/%(playlist_index)s_-_%(id)s.%(ext)s" --restrict-filenames "<URL>"

if len(sys.argv) > 1:
    videos_dir = sys.argv[1]
else:
    videos_dir = os.getcwd()

files = glob.glob(os.path.join(videos_dir, "*.mp4"))
files.extend(glob.glob(os.path.join(videos_dir, "*.mkv")))
files.extend(glob.glob(os.path.join(videos_dir, "*.webm")))
files.sort()

for file in files:
    base_file = os.path.basename(file)
    if base_file.endswith(".mkv"):
        thumb_file=base_file.replace(".mkv", "-thumb.jpg")
    elif base_file.endswith(".mp4"):
        thumb_file=base_file.replace(".mp4", "-thumb.jpg")
    elif file.endswith(".webm"):
        thumb_file=base_file.replace(".webm", "-thumb.jpg")
    command = ['ffprobe', '-v', 'error', '-show_entries', 'format=duration', '-of', 'default=nokey=1:noprint_wrappers=1', file]
    result = subprocess.run(command, capture_output=True, text=True, check=True)
    secs = float(result.stdout)
    sec_offset = secs * 0.10
    command = ['ffmpeg', '-y', '-ss', str(sec_offset), '-i', base_file, '-frames:v', '1', thumb_file]
    result = subprocess.run(command, capture_output=True, text=True, check=True)

