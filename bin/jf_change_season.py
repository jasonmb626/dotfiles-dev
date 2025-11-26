#!/usr/bin/env python3
import sys
import os
import glob

# Things to change:
# Directory Name
# poster Name
# seasonnumber tag in season.nfo
# season tag in all other nfos

def change_tag_in_file (nfo_file_path, tag, new_value):
    with open(nfo_file_path, 'r') as nfo_file:
        nfo_file_contents = nfo_file.readlines()
    with open(nfo_file_path, 'w') as nfo_file:
        for line in nfo_file_contents:
            if tag in line:
                nfo_file.write(f"  <{tag}>{new_value}</{tag}>\n")
            elif 'season.nfo' in nfo_file_path and 'sorttitle' in line:
                title = line.strip('\n').split(' - ')[1].replace('</sorttitle>', '').strip(' ')
                new_sort_title = f"{new_value:02d} - {title}"
                nfo_file.write(f"  <sorttitle>{new_sort_title}</sorttitle>\n")
            else:
                nfo_file.write(line)

if len(sys.argv) < 3:
    print ('Must provide old and new season numbers.')
    sys.exit(1)

try:
    old_season_nbr = int(sys.argv[1])
    new_season_nbr = int(sys.argv[2])
except:
    print ('season #s must be integers')
    sys.exit(2)

cwd = os.getcwd()
old_path = os.path.join(cwd, f"Season {old_season_nbr:02d}")
if not os.path.exists(old_path):
    print("Error: old season dir does not exist")
    sys.exit(3)
new_path = os.path.join(cwd, f"Season {new_season_nbr:02d}")
if os.path.exists(new_path):
    print("Error: new season dir already exists.")
    sys.exit(4)

try:
    os.rename(old_path, new_path)
except:
    print("Failed to rename directory")
    sys.exit(5)

old_poster_file = f"season{old_season_nbr:02d}-poster.jpg"
new_poster_file = f"season{new_season_nbr:02d}-poster.jpg"
os.rename(os.path.join(cwd, old_poster_file), os.path.join(cwd, new_poster_file))
files = [os.path.basename(i) for i in glob.glob(os.path.join(new_path, "*.nfo"))]
for file in files:
    if file == 'season.nfo':
        tag_to_change = 'seasonnumber'
    else:
        tag_to_change = 'season'
    change_tag_in_file (os.path.join(new_path, file), tag_to_change, new_season_nbr)



