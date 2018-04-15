#!/bin/bash
# flactomp3.sh
# Convert FLAC files to MP3 using ffmpeg

echo "FLAC to MP3 0.1"

for file in *.flac
do
  # convert FLAC to VBR V0 MP3 and copy ID3 tags
  ffmpeg -i "$file" -aq 0 -map_metadata 0 "${file%.flac}.mp3"
done
