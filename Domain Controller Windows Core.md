# First Domain Delopyment 

Step 1: Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

Step 2: Import-Module ADDSDeployment

Step 3: Install-ADDSForest --> Type domain name --> Safepassword

# Second Domain Deployment:

Step 1: Install-ADDSDomainController
