
## Resolving Account Duplication Issues in Azure AD due to ObjectGUID Mismatch

If you encounter account duplication issues or problems with merging accounts in Azure AD, it may be due to a mismatch between the `ObjectGUID` in your local domain and the `ImmutableID` in Azure AD. To address this, you can manually align these IDs using PowerShell. Follow these steps:

### Step 1: Prepare the Affected Account
1. **Move the User in Local AD**: Log into your local Active Directory (AD) and move the affected user into an Organizational Unit (OU) that is not synchronized with Azure AD.
2. **Delete from Azure AD**: Log into Azure AD Microsoft Entra and permanently delete the affected account.

### Step 2: Retrieve ObjectGUID
Retrieve the `ObjectGUID` from your local domain for the affected user. Use the following PowerShell command:

```powershell
Get-ADUser -Filter {UserPrincipalName -eq "mohammad@domain.com"} | Select-Object objectGUID
```

**Example Output**:
```
87ab9894-1863-4282-a5a0-87256e189f31
```

### Step 3: Convert ObjectGUID to ImmutableID
Convert the `ObjectGUID` to an `ImmutableID` using this command:

```powershell
[system.convert]::ToBase64String(([guid](get-aduser -identity mohammad).objectguid).ToByteArray())
```

**Example Output**:
```
lJirh2MYgkKloIclbhifMQ==
```

### Step 4: AzureAD PowerShell Module
Log into Azure AD using PowerShell:

```powershell
connect-azuread
```
Then, sign in with your account credentials.

### Step 5: Set ImmutableID
Before setting the new `ImmutableID`, ensure you don't encounter the error:

```Set-AzureADUser : Error occurred while executing SetUser
Code: Request_BadRequest
Message: Another object with the same value for property immutableId already exists.
RequestId: 60c3abc9-e30d-4079-a11a-3385609071b3
DateTimeStamp: Wed, 24 Jan 2024 07:41:54 GMT
Details: PropertyName  - immutableId, PropertyErrorCode  - ObjectConflict, ConflictingObjects  -
User_20512628-877a-47c1-b58d-bbf353bc7736
HttpStatusCode: BadRequest
HttpStatusDescription: Bad Request
HttpResponseStatus: Completed
At line:1 char:1
+ Set-AzureADUser -ObjectId "mohammad@domain.com" -ImmutableId "lJirh ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Set-AzureADUser], ApiException
    + FullyQualifiedErrorId : Microsoft.Open.AzureAD16.Client.ApiException,Microsoft.Open.AzureAD16.PowerShell.SetUser
```

To avoid this, use the following commands:

1. **Remove Existing ImmutableID**:
   ```powershell
   Set-AzureADUser -ObjectId "mohammad@domain.com" -ImmutableId $null
   Start-ADSyncSyncCycle -PolicyType Delta
   ```
   Wait for the sync cycle to complete.

2. **Assign New ImmutableID**:
   ```powershell
   Set-AzureADUser -ObjectId "mohammad@domain.com" -ImmutableId "ml6E4r1h+k6wTG97J6aCzg=="
   ```

### Completion
After performing these steps, the issue should be resolved. The accounts in the local domain and Azure AD should now be properly synchronized with matching identifiers.
