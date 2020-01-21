***********************************************DiscoverSchelduledTasks.ps1***********************************************
# Script: DiscoverSchelduledTasks.ps1
# Author: Jai
# This script is intended for use with Zabbix > 3.x
# Add to Zabbix Agent
#   UserParameter=TaskSchedulerMonitoring[*],powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent\DiscoverScheduledTasks.ps1" "$1" "$2"
## Change the $path variable to indicate the Scheduled Tasks subfolder to be processed as "\nameFolder\" or "\nameFolder2\subfolder\" see (Get-ScheduledTask -TaskPath )


$path = "*"
#$path = "\*","\C:\","\C:\TachesPlanifie\"


Function Convert-ToUnixDate ($PSdate) {
   $epoch = [timezone]::CurrentTimeZone.ToLocalTime([datetime]'1/1/1970')
   (New-TimeSpan -Start $epoch -End $PSdate).TotalSeconds
}

$ITEM = [string]$args[0]
$ID = [string]$args[1]

switch ($ITEM) {
  "DiscoverTasks" {
$apptasks = Get-ScheduledTask -TaskPath $path | where {$_.state -eq "Ready" -or $_.state -eq "Running"}
$apptasksok = $apptasks.TaskName
#echo $apptasksok
$idx = 1
write-host "{"
write-host " `"data`":[`n"
foreach ($currentapptasks in $apptasksok)
{
    if ($idx -lt $apptasksok.count)
    {
     
        $line= "{ `"{#APPTASKS}`" : `"" + $currentapptasks + "`" },"
        write-host $line
    }
    elseif ($idx -ge $apptasksok.count)
    {
    $line= "{ `"{#APPTASKS}`" : `"" + $currentapptasks + "`" }"
    write-host $line
    }
    $idx++;
} 
write-host
write-host " "
write-host "]}"}}



switch ($ITEM) {
  "TaskLastResult" {
[string] $name1 = $ID -eq "1"
$pathtask = Get-ScheduledTask -TaskPath $path -TaskName "$name1"
$pathtask1 = $pathtask.Taskpath
$taskResult = Get-ScheduledTaskInfo -TaskPath "$pathtask1" -TaskName "$name1"
Write-Output ($taskResult.LastTaskResult)
}}

switch ($ITEM) {
  "TaskLastRunTime" {
[string] $name1 = $ID
$pathtask = Get-ScheduledTask -TaskPath $path -TaskName "$name1"
$pathtask1 = $pathtask.Taskpath
$taskResult = Get-ScheduledTaskInfo -TaskPath "$pathtask1" -TaskName "$name1"
$taskResult1 = $taskResult.LastRunTime
$date = get-date -date "01/01/1970"
$taskResult2 = (New-TimeSpan -Start $date -end $taskresult1).TotalSeconds
Write-Output ($taskResult2)
}}

switch ($ITEM) {
  "TaskNextRunTime" {
[string] $name1 = $ID
$pathtask = Get-ScheduledTask -TaskPath $path -TaskName "$name1"
$pathtask1 = $pathtask.Taskpath
$taskResult = Get-ScheduledTaskInfo -TaskPath "$pathtask1" -TaskName "$name1"
$taskResult1 = $taskResult.NextRunTime
$date = get-date -date "01/01/1970"
$taskResult2 = (New-TimeSpan -Start $date -end $taskresult1).TotalSeconds
Write-Output ($taskResult2)
}}

switch ($ITEM) {
  "TaskState" {
[string] $name1 = $ID
$pathtask = Get-ScheduledTask -TaskPath "$path" -TaskName "$name1"
$pathtask1 = $pathtask.State
Write-Output ($pathtask1)
}}

***********************************************by Jai***********************************************
