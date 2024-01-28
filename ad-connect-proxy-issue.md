## Resolving AD Connect Proxy Issue

### Error Description

The on-premise synchronization service is not able to connect to Azure Active Directory (Azure AD). Updating the proxy settings for the AD Sync service account may resolve this issue.

### Solution Steps

1. **Navigate to the Configuration File**:
   Use the File Explorer to navigate to the `machine.config` file located at:

C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\machine.config


2. **Edit the Configuration File**:
Open the `machine.config` file with a text editor like Notepad with administrative privileges. Add the following lines at the bottom of the file, just before the `</configuration>` tag:

```xml
<system.net>
    <defaultProxy>
        <proxy
            usesystemdefault="true"
            proxyaddress="http://IP-Address-Or-DNS-Name:Port"
            bypassonlocal="true"
        />
    </defaultProxy>
</system.net>

Replace IP-Address-Or-DNS-Name:Port with the actual IP address or DNS name and port number of your proxy.

Retry Synchronization:
Save the changes to machine.config and close the text editor. Now, retry the synchronization process; it should work correctly with the updated proxy settings.
Important Note
Be cautious when editing the machine.config file, as incorrect settings can affect all applications that use the .NET Framework on that machine. It is advisable to backup the machine.config file before making any changes.


Before you proceed with these steps, please ensure that you have the correct proxy settings and that you have administrative privileges to edit the `machine.config` file. Always make a backup before editing system configuration files.
