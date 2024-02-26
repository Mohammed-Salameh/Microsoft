# Microsoft

*This repository contains the scripts and configuration settings for Microsoft services.*

### PowerShell & Group Policies

*Remember, these Scripts assume a certain level of familiarity with PowerShell and Group Policy Management in a Windows Server environment. Always test scripts and policies in a controlled environment before deploying them domain-wide.*

### Azure AD Connect

*Before deployment, it's crucial to perform a directory cleanup. Identify and rectify any issues in your on-premises AD, such as duplicate attributes, invalid characters, and unsupported objects. Use tools like IdFix to identify and fix these issues.*

*Ensure that the necessary endpoints are accessible from the server where Azure AD Connect will be installed. This may involve configuring firewalls and proxy servers to allow communication with Azure AD.*

*Understand the security implications, including the use of privileged accounts and how credentials are stored. Implement MFA for accounts with access to Azure AD Connect.*

*Be aware of common issues and their resolutions, such as synchronization errors, connector issues, or authentication problems.*

