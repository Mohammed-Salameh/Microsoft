# PowerShell script to set lock screen image and reset permissions 27-11-2023 (windows 10 & 11)

## Adding Registry Keys for Personalization
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImagePath" -Value "c:\windows\web\screen\image.jpg" -Type String -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageUrl" -Value "c:\windows\web\screen\image.jpg" -Type String -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageStatus" -Value 1 -Type DWord -Force

## Resetting permissions on SystemData folder
icacls "C:\ProgramData\Microsoft\Windows\SystemData" /reset /t /c /l


### create a user gpo and call it Lock Screen Configuration Policy
### navigate to User Configuration -> Perferences -> Files -> and copy the picture to folder c:\windows\web\screen
### create a script call it lockscreen.ps1
### copy the script file to \\dc\sysvol\yourdomain\scripts\
### Navigate to Users Configuration -> Perferences -> Folders -> Create a new folder and call it Scripts
  Path c:\Scripts
### Navigate to User Configuration -> Perferences -> Files -> and copy the script to c:\scripts
### navigate to Users Configuration -> Policies -> Windows Settings -> Scripts -> Double click Logon and add the below values
#### Script Name:
   C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
#### Script Parameteres 
  -ExecutionPolicy Bypass -NoProfile -File "c:\scripts\lockscreen.ps1"
