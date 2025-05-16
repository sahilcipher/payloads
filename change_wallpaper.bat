@echo off
title Wallpaper Changer by Sahil Parmar
echo Changing your wallpaper...

:: Set Variables
set "wallpaper_url=https://img.freepik.com/free-photo/sight-terrifying-clown-with-scary-make-up_23-2150634932.jpg"
set "temp_folder=%TEMP%\WallpaperChanger"
set "wallpaper_path=%temp_folder%\scary_wallpaper.jpg"

:: Create Temporary Directory
if not exist "%temp_folder%" mkdir "%temp_folder%"

:: Download the Wallpaper using PowerShell (Hidden)
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%wallpaper_url%', '%wallpaper_path%')" >nul 2>&1

:: Set the Wallpaper using Registry (Active Desktop Method)
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%wallpaper_path%" /f
reg add "HKCU\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d 2 /f
reg add "HKCU\Control Panel\Desktop" /v TileWallpaper /t REG_SZ /d 0 /f

:: Apply the Wallpaper Change
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

echo Wallpaper has been changed successfully.
exit
