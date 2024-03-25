Add-Type -AssemblyName System.Windows.Forms

$username = Read-Host -Prompt "What is your username?"
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
$result = $FileBrowser.ShowDialog()

$result
if($result -eq "OK"){
    $password = Get-Content $FileBrowser.FileName | ConvertTo-SecureString
    $cred = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
    $userToRemove = Read-Host -Prompt "What email address do you want removed?"

    Connect-MsolService -Credential $cred
    Remove-MsolUser -UserPrincipalName $userToRemove -Force
    Read-Host $userToRemove "has been removed...press any key to continue"
}