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

#user variables
gamefolder=""

#program variables
dmc1_dir="$gamefolder/data/dmc1/Video/" #video folder is Uppercased while audio folder is not don't ask why
dmc2_dir="$gamefolder/data/dmc2/Video/"
dmc3_dir="$gamefolder/data/dmc3/Video/"
dmcL_dir="$gamefolder/data/dmclauncher/video/"
video_dir=""
backup_dir=""
count_to="77" #there are 77 videos files to go tho
count=0

#check if this system has ffmpeg installed
if [ ! command -v ffmpeg &> /dev/null ]; then
  echo "Pls install ffmpeg and rerun the script"
  exit 127
fi 

#oh no im not using a for loop
#anyway you can comment out remux_dmc_fmv if you want to skip remuxing a certain game
main() {
  video_dir="$dmc1_dir"
  update_backup_dir
  remux_dmc_fmv
  video_dir="$dmc2_dir"
  update_backup_dir
  remux_dmc_fmv
  video_dir="$dmc3_dir"
  update_backup_dir
  remux_dmc_fmv
  video_dir="$dmcL_dir"
  update_backup_dir
  remux_dmc_fmv
}

#lets not repeat this fragile code more than once
update_backup_dir() {
  suffix=$(basename -- "$video_dir") 
  backup_dir="${video_dir%$suffix/}/video_bk/" #will break if the video_dir var doesn't end with a /
}

#what actually does the work
remux_dmc_fmv() {
  #make backup if it doesn't exist
  if [ ! -d "$backup_dir" ]; then
    mv "$video_dir" "$backup_dir"
  fi

  #make folder because we might have moved before
  #error out and continue otherwise 
  mkdir "$video_dir"

  #just so you know when it will end
  echo "$count/$count_to"

  for fmv in "${backup_dir}"*
  do 
    #convert to mp4 and flip image vertically as per https://www.nexusmods.com/devilmaycryhdcollection/mods/51?tab=description
    ffmpeg -loglevel error -stats -i "$fmv" -f mp4 -vf vflip "${fmv/$backup_dir/$video_dir}"
    let count++
    echo "$count/$count_to"

  done

  echo "Done for this game you can delete:" 
  echo "    $backup_dir"
  echo "If you don't want to keep the original files"
}

main "$@"; exit
