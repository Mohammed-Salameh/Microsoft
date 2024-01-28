## Fixing "Message Store Has Reached Its Maximum Size" Error in Microsoft 365

If you encounter the error message "Message store has reached its maximum size" in Microsoft 365, it's likely because your Outlook data file (PST) has reached the size limit. To resolve this issue, you will need to modify the Windows Registry to increase the maximum size allowed for the PST file.

### Instructions

1. **Navigate to the Registry Key**:
   Open the Registry Editor by pressing `Win + R`, typing `regedit`, and pressing `Enter`. Then navigate to the following path:

Computer\HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\PST


2. **Create the following entries**:
Right-click on the `PST` key, select `New` > `DWORD (32-bit) Value`

- `MaxLargeFileSize`:
  - **Name**: `MaxLargeFileSize`
  - **Type**: `DWORD (32-bit) Value`
  - **Value**: `92160` (This sets the limit to 90 GB)

- `WarnLargeFileSize`:
  - **Name**: `WarnLargeFileSize`
  - **Type**: `DWORD (32-bit) Value`
  - **Value**: `90112` (This sets the warning threshold to 88 GB)

Ensure that you enter the value data in Decimal, not Hexadecimal.

3. **Restart Outlook**:
Close the Registry Editor, then restart Microsoft Outlook. The issue should now be resolved, and you should be able to use your message store without encountering the size limit error.

Please note: Modifying the Windows Registry can cause serious problems if not done correctly. It's recommended that you back up the registry before making any changes and only proceed if you are comfortable with these steps.
