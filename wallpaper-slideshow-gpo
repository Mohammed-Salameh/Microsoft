Remember, these instructions assume a certain level of familiarity with PowerShell and Group Policy Management in a Windows Server environment. Always test scripts and policies in a controlled environment before deploying them domain-wide.

## Preparation:
1. **Script Creation:**
   - Open PowerShell ISE.
   - Copy the script provided below.
   - Save the file with the name "wallpaper-slideshow.ps1".

2. **Script Placement:**
   - Copy the `.ps1` script file into the shared directory `\\dc\sysvol\yourdomain\scripts\`.
   - Note: This path is typically used for domain-wide script storage in a Windows server environment.

## Group Policy Configuration:
3. **New User Policy Creation:**
   - Create a new User Policy in your domain's Group Policy Management.

4. **Folder Configuration:**
   - Navigate to `User Configuration -> Preferences -> Folders`.
   - Add a folder named "C:\wallpaper".
   - Note: If you change the folder location or name, you must also modify the encrypted path in the script accordingly.

5. **Wallpaper Storage Setup:**
   - Go to `\\dc\sysvol\yourdomain\installation`.
   - Create a new folder named "wallpaper".

6. **File Management:**
   - Navigate to `User Configuration -> Preferences -> Files`.
   - Set up a file copy action from `\\dc\sysvol\yourdomain\installation\wallpaper\image.jpg` to the destination folder `C:\wallpaper`.
   - You can copy multiple images or use a script for automation.

7. **Logon Script Configuration:**
   - Go to `User Configuration -> Policies -> Scripts -> Logon Script`.
   - Add the following:
     - Script Name: `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`
     - Script Parameters: `-ExecutionPolicy Bypass -NoProfile -File "c:\wallpaper\wallpaper-slideshow.ps1"`

## Script Details:
8. **Script Parameters:**
   - Configure the slideshow settings, such as shuffle and interval.
   - The `$TargetPIDL` variable holds an encrypted path and should be modified if the folder location changes.

9. **Running in ISE:**
   - The script includes a section to facilitate running within PowerShell ISE.

10. **Registry Modifications:**
    - The script creates and modifies several registry entries to set up the wallpaper slideshow.
    - It sets the wallpaper style, interval, shuffle, and directory path.

11. **Final Steps:**
    - The script restarts the Explorer process to apply the changes.

---

# Configure CurrentUser Sourcefolder, Slideshow (BackgroundType = 2) and inform that the directory has been set
param (
[switch]$Shuffle,
[string]$IntervalMiliseconds = "10000",
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
