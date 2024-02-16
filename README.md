# dmc-hd-collection-fix-for-linux
Fixes Cutscreens in the dmc hd collection


## USAGE
Change the **gamefolder** variable in the [Script](dmc_hd_collection_video_fix.sh) to the folder of the game that has this folder structure:
```
 .
 ├── data
 ├── Wallpaper
 ├── dmc1.exe
 ├── dmc2.exe
 ├── dmc3.exe
 ├── dmcLauncher.exe
 ├── fmod64.dll
 ├── fmodstudio64.dll
 ├── Newtonsoft.Json.dll
 └── steam_api64.dll
 ```
You can find this folder by **right-clicking** the game on steam > **Manage** > **Browse local files**

Then run the script

Don't forget to set the script as executable

## DEPENDS ON
- [ffmpeg](https://ffmpeg.org/)
- [RTFM](https://en.wikipedia.org/wiki/RTFM)

## why?
well there is a [mod](https://www.nexusmods.com/devilmaycryhdcollection/mods/51?tab=description) for this already but the "mod" is basically piracy because it gives you the files already transcoded files and gives you 2 ways for doing it yourself and you can't download without login but lets be real here i did this because the mod gave a code snippet with 
> rm -rf
