# PowerShell script to set lock screen image (windows 10 & 11)

## Resetting permissions on SystemData folder
icacls "C:\ProgramData\Microsoft\Windows\SystemData" /reset /t /c /l

This script will create a new registry key for `PersonalizationCSP` if it doesn't already exist and set the properties to define the lock screen image path and status. Remember to run PowerShell as an administrator when executing scripts that modify the registry. Also, ensure that the image path `C:\Windows\Web\Screen\image.jpg` is correct and that the image file exists at that location before running the script.

## Adding Registry Keys for Personalization
```powershell
# PowerShell script to set lock screen image

# Create the required key if it doesn't exist
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Force

# Set the lock screen image path
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImagePath" -Value "C:\Windows\Web\Screen\image.jpg" -Type String -Force

# Set the lock screen image URL
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageUrl" -Value "C:\Windows\Web\Screen\image.jpg" -Type String -Force

# Enable the lock screen image
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageStatus" -Value 1 -Type DWord -Force
```
 **create a user gpo and call it Lock Screen Configuration Policy** 
 
 **navigate to User Configuration -> Perferences -> Files -> and copy the picture to folder c:\windows\web\screen** 
 
 **create a script call it lockscreen.ps1** 
 
 **copy the script file to \\dc\sysvol\yourdomain\scripts\**
 
 **Navigate to Users Configuration -> Perferences -> Folders -> Create a new folder and call it Scripts
  Path c:\Scripts**
  
 **Navigate to User Configuration -> Perferences -> Files -> and copy the script to c:\scripts**
 
 **navigate to Users Configuration -> Policies -> Windows Settings -> Scripts -> Double click Logon and add the below values**
 
#### Script Name:

   **C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe**
   
#### Script Parameteres 

  **-ExecutionPolicy Bypass -NoProfile -File "c:\scripts\lockscreen.ps1"**


