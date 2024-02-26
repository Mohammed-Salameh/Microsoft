# Microsoft

*This repository contains the scripts and configuration settings for Microsoft services.*

### PowerShell

*Remember, these Scripts assume a certain level of familiarity with PowerShell in a Windows Server environment. Always test scripts in a controlled environment before deploying them.*

### Group Policies 

*Be aware of the GPO processing order (LSDOU: Local, Site, Domain, and then OU) and how GPOs applied at different levels may interact or override each other due to inheritance.*

*Always test new or modified GPOs in a staging or test environment that mirrors the production environment as closely as possible.*

*Utilize the Group Policy Modeling and Results wizards in the Group Policy Management Console (GPMC) to predict and review the impact of GPO deployments.*

*Make changes incrementally and document each change. This practice makes troubleshooting easier if something goes wrong.*

*Carefully consider who has permission to create, link, and edit GPOs. Use role-based access control to minimize the risk of unauthorized or accidental changes.*

*Understand the refresh intervals for GPOs and adjust if necessary, keeping in mind the balance between policy update needs and system performance.*

*Keep Administrative Templates (.admx files) updated to support new policies, especially after upgrading operating systems or deploying new applications.*

### Azure AD Connect

*Before deployment, it's crucial to perform a directory cleanup. Identify and rectify any issues in your on-premises AD, such as duplicate attributes, invalid characters, and unsupported objects. Use tools like IdFix to identify and fix these issues.*

*Ensure that the necessary endpoints are accessible from the server where Azure AD Connect will be installed. This may involve configuring firewalls and proxy servers to allow communication with Azure AD.*

*Understand the security implications, including the use of privileged accounts and how credentials are stored. Implement MFA for accounts with access to Azure AD Connect.*

*Be aware of common issues and their resolutions, such as synchronization errors, connector issues, or authentication problems.*

