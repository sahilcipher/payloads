# Set variables
$imageUrl = "https://wallpapercave.com/download/joker-4k-wallpapers-wp4528934"
$outputPath = "$env:TEMP\joker_wallpaper.jpg"

# Download the image
Invoke-WebRequest -Uri $imageUrl -OutFile $outputPath

# Define the SPI function from user32.dll
Add-Type @"
using System.Runtime.InteropServices;
public class Wallpaper {
  [DllImport("user32.dll", SetLastError = true)]
  public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# Set the wallpaper
[Wallpaper]::SystemParametersInfo(20, 0, $outputPath, 3)
