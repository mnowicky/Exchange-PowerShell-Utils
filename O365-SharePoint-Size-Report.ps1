#Parameters
$SiteURL = "https://theartcraftgroupllc.sharepoint.com/sites/PromotionsNow"
$FolderSiteRelativeURL =  "/Documents/EgnyteFiles"
 
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL 
     
#Get the folder
$Folder = Get-PnPFolder -Url $FolderSiteRelativeURL -Includes ListItemAllFields
 
#Get the total Size of the folder - with versions
Write-host "Size of the Folder:" $([Math]::Round(($Folder.ListItemAllFields.FieldValues.SMTotalSize.LookupId/1KB),2))


#Read more: https://www.sharepointdiary.com/2018/06/sharepoint-online-get-folder-size-using-powershell.html#ixzz7Pmha703i