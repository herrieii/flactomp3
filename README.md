# flactomp3
A shell script that converts FLAC files to MP3 using [FFmpeg](https://ffmpeg.org).

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

Enter the target directory and execute the script:

```
flactomp3 Music/Kanye\ West\ -\ Graduation
```

Then follow the instructions.

The destination files are placed in the target directory.
