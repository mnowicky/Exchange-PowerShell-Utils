#Session to Microsoft Azure AD (Use if Azure AD session inactive)
$msolcred = get-credential
connect-msolservice -credential $msolcred

#SkuId details

$removeskuid = "TheArtcraftGroupLLC:TEAMS_EXPLORATORY"
$addskuid = "TheArtcraftGroupLLC:O365_BUSINESS_ESSENTIALS"

#Import data from CSV file

    $users = import-csv "D:\MSP_Clients\Artcraft\O365\Replace_License.csv"

#Assign License & Location based on UserPrincipalName from the CSV.   
    foreach ($user in $users)
    {
        $upn=$user.UserPrincipalName
        $usagelocation= "US"
        Set-MsolUserLicense -UserPrincipalName $upn -RemoveLicenses "$removeskuid"
        Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses "$addskuid"
        Write-Host "License" $addskuid "Assigned to UPN" $upn
    } 
