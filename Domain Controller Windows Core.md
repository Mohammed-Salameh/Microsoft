### First Domain Deployment on Windows Server Core

#### Step 1: Install Active Directory Domain Services

Open a PowerShell session with administrative privileges. You can do this by typing `powershell` in the command prompt after logging into your Windows Server Core installation.

Install the AD DS role along with the management tools by executing:

```powershell
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
```

#### Step 2: Import the ADDSDeployment PowerShell Module

After installing the AD DS role, you need to import the ADDSDeployment module, which provides the cmdlets necessary for setting up and configuring Active Directory:

```powershell
Import-Module ADDSDeployment
```

#### Step 3: Deploy the New AD DS Forest

To create a new AD DS forest with a specified NetBIOS name, use the `Install-ADDSForest` cmdlet. Here, you'll need to provide the FQDN of your new domain, specify the NetBIOS name, and set a Safe Mode Administrator Password:

```powershell
Install-ADDSForest -DomainName "yourdomain.com" -DomainNetbiosName "YOURNETBIOS" -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText "YourSafePassword" -Force) -NoRebootOnCompletion
```

- `DomainName` should be replaced with your desired domain name.
- `DomainNetbiosName` should be replaced with your desired NetBIOS name, which is limited to 15 characters.
- Replace `"YourSafePassword"` with a strong password of your choosing for the Directory Services Restore Mode (DSRM).

**Note:** The `-NoRebootOnCompletion` parameter is optional and allows you to decide when to reboot the server manually after the installation.

## Second Domain Deployment on Windows Server Core (Additional Domain Controller)

### Join the Server to the Existing Domain

Before you can promote the server to a domain controller, it must be a member of the domain. Use the following command to join the server to the domain. You'll need to replace `yourdomain.com` with your domain's name and provide the credentials of a user who has permission to join machines to the domain.

1. **Join the Domain:**

```powershell
Add-Computer -DomainName "yourdomain.com" -Credential YourDomain\User -Restart
```

After executing this command, the server will restart.

### Promote the Server to a Domain Controller

After the server has restarted and is now a member of the domain, you can proceed to promote it to a domain controller.

2. **Promote the Server:**

Since you're working with an existing domain, here's how to promote the server to a domain controller with a single command. You would typically use the `Install-ADDSDomainController` cmdlet for this purpose. 

```powershell
Install-ADDSDomainController -DomainName "yourdomain.com" -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText "YourSafePassword" -Force) -Credential (Get-Credential) -NoGlobalCatalog:$false -NoRebootOnCompletion
```

In this command:
- Replace `"yourdomain.com"` with the name of your existing domain.
- `"YourSafePassword"` should be replaced with a secure password for the Directory Services Restore Mode (DSRM).
- `-Credential (Get-Credential)` prompts you to enter the username and password of an account that has permissions to add domain controllers to the existing domain.

**Note:** The `-NoRebootOnCompletion` parameter is optional. It allows you to control when the server reboots, but you must reboot the server to complete the promotion process.

This process ensures that your new server is properly joined to the domain and then promoted to a domain controller, ready to replicate the Active Directory data from an existing domain controller. Remember, these steps are executed in a PowerShell session with administrative privileges, particularly suited for Windows Server Core environments where GUI-based tools are not available.
