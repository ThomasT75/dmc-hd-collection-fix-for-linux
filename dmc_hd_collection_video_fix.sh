#! /bin/bash

######### USAGE ##########
#change the gamefolder variable to the folder of the game that has this folder structure then run the script
# .
# ├── data
# ├── Wallpaper
# ├── dmc1.exe
# ├── dmc2.exe
# ├── dmc3.exe
# ├── dmcLauncher.exe
# ├── fmod64.dll
# ├── fmodstudio64.dll
# ├── Newtonsoft.Json.dll
# └── steam_api64.dll
#
# don't forget to set the script as executable
#
######## DEPENDS ON ##########
# ffmpeg
# RTFM

#variables
gamefolder=""
video_dir="$gamefolder/data/dmc1/Video/" #video folder is Uppercased while audio folder is not don't ask why
backup_dir="$gamefolder/data/dmc1/Video_bk/"

#check if this system has ffmpeg installed
if [ ! command -v ffmpeg &> /dev/null ]; then
  echo "Pls install ffmpeg and rerun the script"
  exit 127
fi 

#make backup if it doesn't exist
if [ ! -d "$backup_dir" ]; then
  mv "$video_dir" "$backup_dir"
fi

#make folder because we might have moved before
#error out and continue otherwise 
mkdir "$video_dir"

#just so you know when it will end
count=0
echo "$count/31"

for fmv in "${backup_dir}"*
do 
  #convert to mp4 and flip image vertically as per https://www.nexusmods.com/devilmaycryhdcollection/mods/51?tab=description
  ffmpeg -loglevel error -stats -i "$fmv" -f mp4 -vf vflip "${fmv/$backup_dir/$video_dir}"
  let count++
  echo "$count/31"

done

echo "done you can delete:" 
echo "    $backup_dir"
echo "if you don't want to keep the original files"
