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

### Second Domain Deployment on Windows Server Core (Additional Domain Controller)

#### Step 1: Install the Additional Domain Controller

For the deployment of an additional domain controller within the existing domain, use the `Install-ADDSDomainController` cmdlet. This will join the server to the domain and replicate the AD DS data:

```powershell
Install-ADDSDomainController `
    -DomainName "yourdomain.com" `
    -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText "YourSafePassword" -Force) `
    -NoGlobalCatalog:$false `
    -NoRebootOnCompletion
```

- Replace `"yourdomain.com"` with the name of your existing domain.
- `"YourSafePassword"` should be replaced with a secure password for the DSRM.
