# list of server names or IP addresses
$serverList = @("DC02","FS01","W")

# Get the current date and time from your local PC
$newDateTime = Get-Date

# Loop through each server and set the new date and time
foreach ($server in $serverList) {
    try {
        # Connect to the remote server
        $session = New-PSSession -ComputerName $server

        # Set the new date and time on the remote server
        Invoke-Command -Session $session -ScriptBlock {
          param($dateTime)
            Set-Date $dateTime  
        } -ArgumentList $newDateTime

        # Close the remote session
        Remove-PSSession $session

        Write-Host "Successfully changed the clock time on $server"
    }
    catch {
        Write-Host "Failed to change the clock time on $server. Error: $_"
    }
}