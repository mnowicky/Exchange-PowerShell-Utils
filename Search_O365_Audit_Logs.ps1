Function Split-O365AuditLogs-FromO365 ()
{
    #Get the content to process
<# 	Write-host " -----------------------------------------" -ForegroundColor Green

	[string]$username = "YourAdminAccount@yourtenant.onmicrosoft.com"
	[string]$PwdTXTPath = "C:\SECUREDPWD\ExportedPWD-$($username).txt"
	$secureStringPwd = ConvertTo-SecureString -string (Get-Content $PwdTXTPath)
	$UserCredential = New-Object System.Management.Automation.PSCredential $username, $secureStringPwd

	#This will prompt the user for credential
#	$UserCredential = Get-Credential

	$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-LiveID/ -Credential $UserCredential -Authentication Basic -AllowRedirection
	Import-PSSession $Session #>

	[DateTime]$startDate = "02/01/2020 00:00" #Format: mm/dd/yyyy hh:MM
	[DateTime]$endDate = "04/05/2020 00:00" #Format: mm/dd/yyyy hh:MM

	$scriptStart=(get-date)
	$sessionName = (get-date -Format 'u')+'o365auditlog'
	# Reset user audit accumulator
	$aggregateResults = @()
	$i = 0 # Loop counter
	Do { 
		Write-host "  >> Audit Request Details: StartDate=", $startDate, "- EndDate=", $endDate
		$currentResults = Search-UnifiedAuditLog -StartDate $startDate -EndDate $enddate -SessionId $sessionName -SessionCommand ReturnLargeSet -ResultSize 1000
		if ($currentResults.Count -gt 0)
		{
			Write-Host ("  Finished {3} search #{1}, {2} records: {0} min" -f [math]::Round((New-TimeSpan -Start $scriptStart).TotalMinutes,4), $i, $currentResults.Count, $user.UserPrincipalName )
			# Accumulate the data
			$aggregateResults += $currentResults
			# No need to do another query if the # recs returned <1k - should save around 5-10 sec per user
			if ($currentResults.Count -lt 1000)
			{
				$currentResults = @()
			}
			else
			{
				$i++
			}
		}
	} Until ($currentResults.Count -eq 0) # --- End of Session Search Loop --- #
	
	[int]$IntemIndex = 1
	$data=@()
    foreach ($line in $aggregateResults)
    {
		Write-host "  ItemIndex:", $IntemIndex, "- Creation Date:", $line.CreationDate, "- UserIds:", $line.UserIds, "- Operations:", $line.Operations
		Write-host "      > AuditData:", $line.AuditData
		$datum = New-Object -TypeName PSObject
		$Converteddata = convertfrom-json $line.AuditData
		
		$datum | Add-Member -MemberType NoteProperty -Name Id -Value $Converteddata.Id
		$datum | Add-Member -MemberType NoteProperty -Name CreationTimeUTC -Value $Converteddata.CreationTime
		$datum | Add-Member -MemberType NoteProperty -Name CreationTime -Value $line.CreationDate
		$datum | Add-Member -MemberType NoteProperty -Name Operation -Value $Converteddata.Operation
		$datum | Add-Member -MemberType NoteProperty -Name OrganizationId -Value $Converteddata.OrganizationId
		$datum | Add-Member -MemberType NoteProperty -Name RecordType -Value $Converteddata.RecordType
		$datum | Add-Member -MemberType NoteProperty -Name ResultStatus -Value $Converteddata.ResultStatus
		$datum | Add-Member -MemberType NoteProperty -Name UserKey -Value $Converteddata.UserKey
		$datum | Add-Member -MemberType NoteProperty -Name UserType -Value $Converteddata.UserType
		$datum | Add-Member -MemberType NoteProperty -Name Version -Value $Converteddata.Version
		$datum | Add-Member -MemberType NoteProperty -Name Workload -Value $Converteddata.Workload
		$datum | Add-Member -MemberType NoteProperty -Name UserId -Value $Converteddata.UserId
		$datum | Add-Member -MemberType NoteProperty -Name ClientIPAddress -Value $Converteddata.ClientIPAddress
		$datum | Add-Member -MemberType NoteProperty -Name ClientInfoString -Value $Converteddata.ClientInfoString
		$datum | Add-Member -MemberType NoteProperty -Name ClientProcessName -Value $Converteddata.ClientProcessName
		$datum | Add-Member -MemberType NoteProperty -Name ClientVersion -Value $Converteddata.ClientVersion
		$datum | Add-Member -MemberType NoteProperty -Name ExternalAccess -Value $Converteddata.ExternalAccess
		$datum | Add-Member -MemberType NoteProperty -Name InternalLogonType -Value $Converteddata.InternalLogonType
		$datum | Add-Member -MemberType NoteProperty -Name LogonType -Value $Converteddata.LogonType
		$datum | Add-Member -MemberType NoteProperty -Name LogonUserSid -Value $Converteddata.LogonUserSid
		$datum | Add-Member -MemberType NoteProperty -Name MailboxGuid -Value $Converteddata.MailboxGuid
		$datum | Add-Member -MemberType NoteProperty -Name MailboxOwnerSid -Value $Converteddata.MailboxOwnerSid
		$datum | Add-Member -MemberType NoteProperty -Name MailboxOwnerUPN -Value $Converteddata.MailboxOwnerUPN
		$datum | Add-Member -MemberType NoteProperty -Name OrganizationName -Value $Converteddata.OrganizationName
		$datum | Add-Member -MemberType NoteProperty -Name OriginatingServer -Value $Converteddata.OriginatingServer
		$datum | Add-Member -MemberType NoteProperty -Name SessionId -Value $Converteddata.SessionId
	
		$data += $datum
		$IntemIndex += 1
	}
	$datestring = (get-date).ToString("yyyyMMdd-hhmm")
	$fileName = ("C:\Temp\O365_UnifiedAuditLogs_" + $datestring + ".csv")
	
	Write-Host (" >>> writing to file {0}" -f $fileName)
	$data | Export-csv $fileName -NoTypeInformation
}

Split-O365AuditLogs-FromO365