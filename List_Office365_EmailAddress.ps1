Add-Type -AssemblyName System.Windows.Forms

$username = 'admin@rubinoserv.com'
$password = Get-Content 'C:\Users\DavidHumphreys\Documents\Passwords\RSC_O365_Admin.txt' | ConvertTo-SecureString
$username2 = 'avasek@williamslopatto.com'
$password2 = Get-Content 'C:\Users\DavidHumphreys\Documents\Passwords\WML_O365_Admin.txt' | ConvertTo-SecureString
$username3 = 'admin@clydelaw.com'
$password3 = Get-Content 'C:\Users\DavidHumphreys\Documents\Passwords\ClydeLaw_O365_Admin.txt'| ConvertTo-SecureString
$username4 = 'admin@brownmeyers.com'
$password4 = Get-Content 'C:\Users\DavidHumphreys\Documents\Passwords\BNM_O365_Admin.txt' | ConvertTo-SecureString
$username5 = 'admin@computabase.com'
$password5 = Get-Content 'C:\Users\DavidHumphreys\Documents\Passwords\CBM_O365_Admin.txt' | ConvertTo-SecureString
$username6 = 'admin@danielmrosenberg.com'
$password6 = Get-Content 'C:\Users\DavidHumphreys\Documents\Passwords\DMR_O365_Admin.txt' | ConvertTo-SecureString
$username7 = 'admin@danieliward.com'
$password7 = Get-Content 'C:\Users\DavidHumphreys\Documents\Passwords\DWard_O365_Admin.txt' | ConvertTo-SecureString
$username8 = 'admin@hartylawgroup.com'
$password8 = Get-Content 'C:\Users\DavidHumphreys\Documents\Passwords\HLG_O365_Admin.txt' | ConvertTo-SecureString
$username9 = 'admin@integritynj.com'
$password9 = Get-Content 'C:\Users\DavidHumphreys\Documents\Passwords\INT_O365_Admin.txt' | ConvertTo-SecureString

$cred = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
$cred2 = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username2, $password2
$cred3 = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username3, $password3
$cred4 = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username4, $password4
$cred5 = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username5, $password5
$cred6 = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username6, $password6
$cred7 = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username7, $password7
$cred8 = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username8, $password8
$cred9 = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username9, $password9


Connect-MsolService -Credential $cred
Write-Host 'Rubino User Accounts'
Get-MsolUser
Read-Host "Press any key to continue"

Connect-MsolService -Credential $cred2
Write-Host 'Williams Lopatto User Accounts'
Get-MsolUser
Read-Host "Press any key to continue"

Connect-MsolService -Credential $cred3
Write-Host 'ClydeLaw User Accounts'
Get-MsolUser
Read-Host "Press any key to continue"

Connect-MsolService -Credential $cred4
Write-Host 'Brown Meyers User Accounts'
Get-MsolUser
Read-Host "Press any key to continue"

Connect-MsolService -Credential $cred5
Write-Host 'CBM User Accounts'
Get-MsolUser
Read-Host "Press any key to continue"

Connect-MsolService -Credential $cred6
Write-Host 'DMR User Accounts'
Get-MsolUser
Read-Host "Press any key to continue"

Connect-MsolService -Credential $cred7
Write-Host 'DWard User Accounts'
Get-MsolUser
Read-Host "Press any key to continue"

Connect-MsolService -Credential $cred8
Write-Host 'HLG User Accounts'
Get-MsolUser
Read-Host "Press any key to continue"

Connect-MsolService -Credential $cred9
Write-Host 'INT User Accounts'
Get-MsolUser
Read-Host "Press any key to continue"