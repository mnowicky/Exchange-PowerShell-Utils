# Import the required modules
Import-Module MSOnline

# Connect to Office 365
Connect-MsolService

# Specify the CSV file path
$csvPath = "C:\Users\rmariano\Avasek\Organization - Documents\Security Services\Incident Response\Clients\West Texas Gas\Email PW Reset - First Round.csv"

# Specify the group name
$groupName = "MFA Required"

# Read the CSV file
$users = Import-Csv $csvPath

# Iterate through each user in the CSV and add them to the group
foreach ($user in $users) {
    $userPrincipalName = $user.UserPrincipalName
    Add-MsolGroupMember -GroupObjectId (Get-MsolGroup -SearchString $groupName).ObjectId -GroupMemberType User -GroupMemberObjectId (Get-MsolUser -UserPrincipalName $userPrincipalName).ObjectId
}
