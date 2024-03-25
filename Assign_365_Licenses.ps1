#Session to Microsoft Azure AD (Use if Azure AD session inactive)

$msolcred = get-credential

connect-msolservice -credential $msolcred

#Import data from CSV file
    $users = import-csv "D:\MSP_Clients\Artcraft\O365\Replace_License.csv"

#Assign License & Location based on UserPrincipalName from the CSV.   
    foreach ($user in $users)
    {
        $upn=$user.UserPrincipalName
        $usagelocation= "US"  #Ensure to enter the correct location based on your user/organization location
        $SKU= "TheArtcraftGroupLLC:O365_BUSINESS_ESSENTIALS" #Ensure to enter the correct AccountSkuID based on your SkuID
        Set-MsolUser -UserPrincipalName $upn -UsageLocation $usagelocation
        Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $SKU
        Write-Host "License Assigned to UPN:"$upn #Return which UserPrincipalName was successfully assigned with the license
    } 
