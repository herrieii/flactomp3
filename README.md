# flactomp3
A shell script that provides a simple interface for converting FLAC files to MP3 using [FFmpeg](https://ffmpeg.org)

## Installation

Make the script executable:

```
chmod +x flactomp3.sh
```

Create an alias:

```
echo "alias flactomp3='$PWD/flactomp3.sh'" >> ~/.bashrc
source ~/.bashrc
```

## Usage

Enter the source directory and destination directory and execute the script:

```
flactomp3 Music/Kanye\ West\ -\ Graduation /media/audiodevice
```

And follow the instructions.
