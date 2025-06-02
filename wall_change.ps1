# Check if running in Bypass already
if ($env:PSExecutionPolicyPreference -ne "Bypass") {
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$PSCommandPath"
    exit
}

# Define the image path
$picturesFolder = "$env:USERPROFILE\Pictures"
$imgPath = Join-Path $picturesFolder "joker.jpg"

# Create folder if not exists
if (!(Test-Path $picturesFolder)) {
    New-Item -ItemType Directory -Path $picturesFolder | Out-Null
}

# Download the wallpaper
Invoke-WebRequest -Uri "https://wallpapercave.com/wp/wp4528934.jpg" -OutFile $imgPath

# Load user32.dll to set wallpaper
Add-Type -TypeDefinition @"
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# Change wallpaper
[Wallpaper]::SystemParametersInfo(20, 0, $imgPath, 0x01 -bor 0x02)
