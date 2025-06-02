# Relaunch with ExecutionPolicy Bypass if needed
if ($env:PSExecutionPolicyPreference -ne "Bypass") {
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$PSCommandPath"
    exit
}

# Define paths
$picturesFolder = "$env:USERPROFILE\Pictures"
$imgPath = Join-Path $picturesFolder "joker.jpg"
$soundPath = Join-Path $picturesFolder "girl_scream.wav"

# Create folder if not exists
if (-not (Test-Path $picturesFolder)) {
    New-Item -ItemType Directory -Path $picturesFolder | Out-Null
}

# Download wallpaper
Invoke-WebRequest -Uri "https://wallpapercave.com/wp/wp4528934.jpg" -OutFile $imgPath

# Download scary sound
Invoke-WebRequest -Uri "https://github.com/sahilcipher/payloads/raw/refs/heads/main/girl_scream-6465.wav" -OutFile $soundPath

# Set wallpaper
Add-Type -TypeDefinition @"
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
[Wallpaper]::SystemParametersInfo(20, 0, $imgPath, 0x01 -bor 0x02)

# Play scream in continuous loop
Add-Type -AssemblyName presentationCore
$player = New-Object System.Media.SoundPlayer
$player.SoundLocation = $soundPath
$player.Load()
$player.PlayLooping()

# Keep the script running infinitely (or until manually closed)
while ($true) {
    Start-Sleep -Seconds 1
}
