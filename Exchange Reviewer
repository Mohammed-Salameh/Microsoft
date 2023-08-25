
## Step 1: Draft a PowerShell Script in ISE
- **Action**: Launch Powershell ISE and initiate a new `.ps1` file named `ExchangeReadOnlyAccess.ps1`.
  
  **Comments**:
  - Use `[CmdletBinding()]` to enable advanced function features.
  - Define three essential parameters: `Mailbox`, `User`, and `Access`. These are marked as mandatory.
  - The `$exclusions` array holds a list of folder paths that need to be excluded from processing.
  - `$mailboxfolders` is an array that captures all mailbox folder paths excluding those in the `$exclusions` list.
  - The `foreach` loop processes each mailbox folder. It corrects the folder path format and checks for the "Top of Information Store" string to replace it accordingly.
  - Within the loop, it grants the specified user the stipulated access permissions to each folder.

## Step 2: Establish a Connection to Microsoft 
- **Action**: Open PowerShell and run `Connect-Exchangeonline`.

  **Comments**: 
  - This command is used to establish a connection to Microsoft Exchange Online.

## Step 3: Execute the PowerShell Script
- **Action**: In the PowerShell window, run the following command:
  ```
  .\ExchangeReadOnlyAccess.ps1 -Access reviewer -Mailbox USER@domain.com.sa -User USER@domain.com.sa
  ```

  **Comments**:
  - This command invokes the previously created script, supplying it with the `Access`, `Mailbox`, and `User` parameters. 
  - It essentially grants the 'reviewer' access to the specified mailbox's folders (except those in the exclusion list) for the designated user.

---

**Note**: Always backup and test scripts in a safe environment before applying them to a live or production system.




1- Create a script file .ps1 using Powershell ISE 

[CmdletBinding()]
param (
	[Parameter( Mandatory=$true)]
	[string]$Mailbox,
    
	[Parameter( Mandatory=$true)]
	[string]$User,
    
  	[Parameter( Mandatory=$true)]
	[string]$Access
)

$exclusions = @("/Sync Issues",
                "/Sync Issues/Conflicts",
                "/Sync Issues/Local Failures",
                "/Sync Issues/Server Failures",
                "/Recoverable Items",
                "/Deletions",
                "/Purges",
                "/Versions"
                )



$mailboxfolders = @(Get-EXOMailboxFolderStatistics $Mailbox | Where {!($exclusions -icontains $_.FolderPath)} | Select FolderPath)

foreach ($mailboxfolder in $mailboxfolders)
{
    $folder = $mailboxfolder.FolderPath.Replace("/","\")
    if ($folder -match "Top of Information Store")
    {
       $folder = $folder.Replace("\Top of Information Store","\")
    }
    $identity = "$($mailbox):$folder"
    Write-Host "Adding $user to $identity with $access permissions"
    Add-MailboxFolderPermission -Identity $identity -User $user -AccessRights $Access -ErrorAction SilentlyContinue
}

2- Connect to microsoft using Connect-Exchangeonline

3- And run the following command for the mailbox and user

.\ExchangeReadOnlyAccess.ps1 -Access reviewer -Mailbox USER@domain.com.sa -User USER@domain.com.sa
