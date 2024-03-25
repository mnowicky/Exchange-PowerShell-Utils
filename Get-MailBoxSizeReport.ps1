<#
NAME: Get Mailbox Size Report
DESC: Gives you a neat little report of which mailboxes are what size. 
TAKES: Nothing
GIVES: A CSV formatted report of mailboxes and their sizes. 

#>

Connect-ExchangeServer -auto; Get-MailboxDatabase | Get-MailboxStatistics | Select DisplayName, TotalItemSize, Database | Sort-Object TotalItemSize -Descending | Export-CSV C:\MBSizes.csv -NoTypeInformation