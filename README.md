# Windows-Scheduled-Tasks-Monitoring-via-Zabbix
Windows Scheduled Tasks Monitoring via Zabbix

Steps are below -

1.	Copy the file DiscoverScheduledTasks.ps1 for folder of Zabbix Agent C:\Program Files\Zabbix Agent
2.	Change if necessary the $path variable in file DiscoverScheduledTasks.ps1, default is "*", can be "\Microsoft\*", etc.
3.	In the configuration file of Zabbix Agent add the following parameters:


Timeout=30
UnsafeUserParameters=1
EnableRemoteCommands=1
UserParameter=TaskSchedulerMonitoring[*],powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent\DiscoverScheduledTasks.ps1" "$1" "$2"

4.	Verify if your Windows Hosts is enable for execute scripts, if no, run in powershell:
Set-ExecutionPolicy RemoteSigned

5.	Restart the Zabbix Agent

