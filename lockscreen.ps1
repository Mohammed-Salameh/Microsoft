# scripts below are for setting lockscreen via powershell script and can be used via gpo

# single lockscreen image script

# PowerShell script to set lock screen image and reset permissions 27-11-2023 (windows 10 & 11)

# Adding Registry Keys for Personalization
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImagePath" -Value "c:\windows\web\screen\ezgif.com-animated-gif-maker.gif" -Type String -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageUrl" -Value "c:\windows\web\screen\ezgif.com-animated-gif-maker.gif" -Type String -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageStatus" -Value 1 -Type DWord -Force

# Resetting permissions on SystemData folder
icacls "C:\ProgramData\Microsoft\Windows\SystemData" /reset /t /c /l