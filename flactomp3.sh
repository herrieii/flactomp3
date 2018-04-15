#!/bin/bash
# flactomp3.sh
# A shell script that converts FLAC files to MP3 using FFmpeg

version="0.2"

echo "FLAC to MP3 $version"

if [ $# -eq 0 ]
then
  echo "No path given. Please enter the directory containing the files you wish to convert."
  echo "Example":
  echo "  `echo "$0" | sed "s|^$HOME|~|"` ~/Music/Kanye\ West\ -\ Graduation"
  exit
fi

if [ ! -d "$1" ]
then
  echo "No such directory. Please check the path of the directory you tried to enter."
  exit
fi

cd "$1"

echo "Target directory:"
echo "  $PWD"

total=`ls *.flac 2> /dev/null | wc -l | bc`  # bc trims whitespace

if [ $total -eq 0 ]
then
  echo "No FLAC files found. Please check the directory you entered."
  exit
fi

echo "Source files:"
ls -1 *.flac | sed 's/^/  /'  # print one file per line and indent

echo -n "Do you want to convert these files? [Y/n] "
read answer
if echo "$answer" | grep -iq ^n  # echo trims whitespace
then
  exit
fi

let count=0

for file in *.flac
do
  # Convert FLAC to MP3 VBR V0 and copy ID3 tags
  ffmpeg -i "$file" -aq 0 -map_metadata 0 "`basename "$file" .flac`.mp3"
  # Count convert if ffmpeg returned exit code 0
  if [ $? -eq 0 ]
  then
    let count=count+1
  fi
done

echo "$count out of $total files converted successfully."

echo -n "Do you want to delete all source files? (This can NOT be undone!) [y/N] "
read answer
if echo "$answer" | grep -iq ^y
then
  rm -v *.flac
  echo "Source files deleted."
fi
