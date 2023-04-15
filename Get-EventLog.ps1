#Enter the Input directory path to import server list.
Clear-Host
$path = Read-Host "Enter the Server path C:\Temp\servers.txt"

#Enter the Output directory path to export the logs.
$outputFile = Read-Host "Enter the export path C:\Temp"

#Getting the content/server list from the mentioned input path.
$serverList = Get-Content -path $path -ErrorAction SilentlyContinue

#Starting Eventlog collection in loop.
Write-host "Levels: '1= Critical','2 = Error','3=Warnings', '4=Information'"
Write-host "Logname: Application; Security; Setup; System."
foreach ($server in $serverList)
{
	write-host "Collecting EventLog Details on $server"
	$Eventlogs =  Invoke-Command -ComputerName $server -ScriptBlock {Get-WinEvent -FilterHashtable @{logname=Read-Host; level=Read-Host} -MaxEvents 10} -ErrorAction SilentlyContinue
	$filename = $server

#Saving the output file into the same directory with ServerName
	$Eventlogs | Export-CSV -Path $outputFile\$filename.csv -Verbose
}
#End of the Script
