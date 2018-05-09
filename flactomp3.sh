#!/bin/bash
# flactomp3.sh
# A shell script that converts FLAC files to MP3 using FFmpeg

version="0.4"

echo "FLAC to MP3 $version"

# MP3 quality level http://wiki.hydrogenaud.io/index.php?title=Recommended_LAME#Recommended_settings_details
quality="0"

if [ $# -eq 0 ]
then
  echo "No path given. Please enter the directory containing the files you wish to convert. Enter a second directory to create a new destination directory."
  echo "Example:"
  echo "  `echo "$0" | sed "s|^$HOME|~|"` ~/Music/Kanye\ West\ -\ Graduation /media/audiodevice"
  exit
fi

if [ ! -d "$1" ]
then
  echo "No such directory. Please check the path of the source directory you tried to enter."
  exit
fi

workingDir="$PWD"

cd "$1"
sourceDir="$PWD"

if [ $# -eq 1 ]
then
  echo "No second path given. Using the source directory as the destination direcory."

  destDir=$sourceDir
else
  cd "$workingDir"
  if [ ! -d "$2" ]
  then
    echo "No such directory. Please check the path of the destination directory you tried to enter."
    exit
  fi

  cd "$2"
  destDir="$PWD"
fi

echo "Source directory:"
echo "  $sourceDir"

echo "Destination directory:"
echo "  $destDir"

cd "$sourceDir"
sourceCount=`ls *.flac 2> /dev/null | wc -l | bc`  # bc trims whitespace

if [ $sourceCount -eq 0 ]
then
  echo "No FLAC files found. Please check the source directory you entered."
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

if [ "$destDir" != "$sourceDir" ]
then
  newDir="${PWD##*/}"
  echo -n "New directory name: [$newDir] "
  read answer
  if [ ! -z "$answer" ]
  then
    newDir=`echo "$answer"`  # trim
  fi

  destDir="$destDir/$newDir"
  mkdir -v "$destDir"
fi

let count=0

for file in *.flac
do
  # Convert FLAC to MP3 and copy ID3 tags
  ffmpeg -i "$file" -aq "$quality" -map_metadata 0 "$destDir/`basename "$file" .flac`.mp3"
  # Count convert if FFmpeg returned exit code 0
  if [ $? -eq 0 ]
  then
    let count=count+1
  fi
done

echo "$count out of $sourceCount files converted."

if [ "$sourceDir" = "$destDir" ]
then
  echo -n "Do you want to delete all source files? (This can NOT be undone!) [y/N] "
  read answer
  if echo "$answer" | grep -iq ^y
  then
    rm -v *.flac
    echo "Source files deleted."
  fi
fi
