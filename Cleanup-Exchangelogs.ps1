<#
NAME: Exchange Server Log Cleanup  
DESC: Cleans up some of the most commonly overpopulated logs, based on their age. 
TAKES: Nothing. Needs a list of all log directories you want cleaned, though.
GIVES: Nothing. Deletes all logs listed in $Paths.
#>

#Edit to configure
$FilePath = "C:\inetpub\logs\LogFiles\W3SVC2" #Path to clean
$FilePath2 = "C:\Program Files\Microsoft\Exchange Server\V15\Logging\ConversationAggregationLog"
$FilePath3 = "C:\Program Files\Microsoft\Exchange Server\V15\Logging\MapiHttp\Mailbox"
$FilePath4 = "C:\Program Files\Microsoft\Exchange Server\V15\Logging\BodyFragmentExtractorLog"
$FilePath5 = "C:\inetpub\logs\LogFiles\W3SVC1"
$FilePath6 = "C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\Mapi"
$FilePath7 = "C:\Program Files\Microsoft\Exchange Server\V15\Logging\Ews"
$FilePath8 = "C:\Program Files\Microsoft\Exchange Server\V15\Logging\CmdletInfra"
#Timekeeping
$Now = Get-Date
$Offset = $Now.AddDays(-14) #Retention Length (2 weeks)
#Working Variables, don't change except to add paths.

$Paths = $Filepath, $Filepath2, $Filepath3, $Filepath4, $Filepath5, $Filepath6, $Filepath7, $Filepath8 
$MyProcess = get-process -id $PID
#Initialization Commands
$MyProcess.PriorityClass = "BelowNormal" #Decrease own process priority to maintain server performance.

Foreach($Path in $Paths){
    $FileSet = Get-ChildItem -path $Path -Recurse
    Foreach($File in $FileSet){

        if($File.LastWriteTime -lt $Offset){
            Write-Host "Deleting" + $File.Fullname -WhatIf
            Remove-Item -path $File.Fullname -WhatIf
    
        }else{Write-Host "Ignoring" + $File.Fullname}
    
    }
}