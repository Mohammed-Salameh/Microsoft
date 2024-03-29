﻿<#
.SYNOPSIS
SetWallPaper.ps1 - This script sets the background option to "Slideshow" with a predefinied folder without user intervention.
.DESCRIPTION
This script does not use any of the official API and must therefore be considered NOT SUPPORTED.
However, this script mimics all necessary steps, that SystemSettings.exe and Explorer.exe would do, to achieve the same
BONUS:
- Script allows you to freely choose the interval instead of fixed intervals
.PARAMETER Shuffle
Define if you want the wallpapers to be handled in order (by which Microsoft means:  1, 1a, 1b, 3, 4, 10, 22, 100, 111, a1, b2...)
.PARAMETER IntervalMiliseconds
Interval to change pictures, can be any number of miliseconds
!!Attention!! The user will overwrite that value as soon as he so much as clicks the number in the settings
.PARAMETER TargetPIDL
You have to extract that Value from a machine that has been set up correctly. The value can be found here: HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers 
.NOTES 
    1.0 22.07.2019 14:51 (GMT+1)
    Initial Version, added parameters and documentation 
    manima.de/2016/09/create-a-lock-screen-slideshow-with-more-than-one-picture-without-gpo-because-theres-none/
#>
# Configure CurrentUser Sourcefolder, Slideshow (BackgroundType = 2) and inform that the directory has been set
param (
[switch]$Shuffle,
[string]$IntervalMiliseconds = "900000",
[string]$TargetPIDL = "eEAFA8BUg/E0gouOpBhoYjAArADMdmBAvMkOcBAAAAAAAAAAAAAAAAAAAAAAAAw7AEDAAAAAAc3VxtLEAcVQMxEUB5XMAAARAkAAEAw7+e3Vxt7dXF3uuAAAAEh3BAAAAYBAAAAAAAAAAAAAAAAAAAwUsdMAXBQYAwGAsBAcAEGAwBQZAIHAAAAGAMJAAAwJA8uvFCAAAEzUQN1td66/Nyx/DFIjECkOjOXLpBAAAQGAAAAAfAAAAwCAAAwdAkGAuBAZA8GA3BwcA4CApBQbA0GAlBgcAMHApBgdAUGAjBwbA4GA0BgcA8GAsBAcAEGAuBQZAwGAfBwYAcHA1AgbAEDAoBgMAQHA4BQeAUGA3BQeAAAAAAAAAAAAAAAGAAAA"
)
#To make the script run in ISE
if ($psISE.CurrentFile.FullPath.Length -ge 1){
    Set-Location $psISE.CurrentFile.FullPath
}
#Set-Location -Path "$Sourcefolder"
#Define vars
$UserProfile = @{"SID" = "";"UserHive" = ""}
try {
    $tsenv = New-Object -ComObject Micrsoft.SMS.TSEnvironment
        if ($tsenv.value("_SMSTSInWinPE") -eq $true){
            $UserProfile.UserHive = "C:\Users\Default\NTUSER.DAT"
            $UserProfile.SID = ".DEFAULT"
        }
}
catch {
    Write-Output "Not in TaskSequence"
    Add-Type -AssemblyName System.DirectoryServices.AccountManagement
    $UserProfile.UserHive = $env:USERPROFILE + "\NTUSER.DAT"
    $UserProfile.SID = ([System.DirectoryServices.AccountManagement.UserPrincipal]::Current).Sid.value
}
if ($Shuffle){
    $ShuffleValue = 1
}
else{
    $ShuffleValue = 0
}
#Create FolderVar
$EncrytpedPath = $TargetPIDL
 
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers -Name SlideshowDirectoryPath1 -PropertyType ExpandString -Value $EncrytpedPath –Force | Out-Null
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers -Name BackgroundType -PropertyType DWord -Value 2 –Force | Out-Null
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers -Name SlideshowSourceDirectoriesSet -PropertyType DWord -Value 1 –Force | Out-Null
 
New-ItemProperty -Path "HKCU:\Control Panel\Personalization\Desktop Slideshow" -Name Shuffle -PropertyType DWord -Value $ShuffleValue –Force | Out-Null
New-ItemProperty -Path "HKCU:\Control Panel\Personalization\Desktop Slideshow" -Name Interval -PropertyType DWord -Value $IntervalMiliseconds –Force | Out-Null
 
if (Test-Path .\slideshow.ini){
    Remove-Item -Path .\slideshow.ini -Force
}
Set-Content .\slideshow.ini -Value "[Slideshow]"
Add-Content .\slideshow.ini -Value "ImagesRootPIDL=$EncrytpedPath"
Copy-Item .\slideshow.ini -Destination ($env:APPDATA+"\Microsoft\Windows\Themes\") -Force
 
 
New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallPaper -PropertyType String -Value "%APPDATA%\Microsoft\Windows\Themes\TranscodedWallpaper" –Force | Out-Null
New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Interval -PropertyType DWord -Value "0xffffffff" –Force | Out-Null
 
 # Set wallpaper style to Fit
New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value "6" –Force | Out-Null

Stop-Process -Name explorer -Force
Start-Process explorer.exe