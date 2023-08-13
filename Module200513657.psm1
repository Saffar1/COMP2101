$networkAdapters = Get-CimInstance Win32_NetworkAdapterConfiguration |
                   Where-Object { $_.IPEnabled }

$report = foreach ($adapter in $networkAdapters) {
    [PSCustomObject]@{
        Description = $adapter.Description
        Index = $adapter.Index
        IPAddress = $adapter.IPAddress -join ', '
        SubnetMask = $adapter.IPSubnet -join ', '
        DNSDomain = $adapter.DNSDomain
        DNSServers = $adapter.DNSServerSearchOrder -join ', '
    }
}

$report | Format-Table -AutoSize

$report | Format-Table -AutoSize | Out-File -FilePath "IP_Configuration_Report.txt"





Write-Host "Hello, World!"
