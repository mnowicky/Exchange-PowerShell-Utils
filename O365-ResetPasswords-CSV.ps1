# Import the CSV file
$csvPath = "C:\Users\ruser\Documents\Email PW Reset - First Round.csv"
$users = Import-Csv -Path $csvPath

# Connect to Office 365
Connect-MsolService

# Iterate through each user in the CSV file and reset their password
foreach ($user in $users) {
    $userPrincipalName = $user.UserPrincipalName
    $newPassword = $user.NewPassword

    # Set the new password
    Set-MsolUserPassword -UserPrincipalName $userPrincipalName -NewPassword $newPassword -ForceChangePassword $true
}
