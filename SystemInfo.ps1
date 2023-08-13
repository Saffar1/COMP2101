function Get-SystemInfo {
    $computerSystem = Get-CimInstance Win32_ComputerSystem
    $operatingSystem = Get-CimInstance Win32_OperatingSystem
    $processor = Get-CimInstance Win32_Processor
    $physicalMemory = Get-CimInstance Win32_PhysicalMemory
    $diskDrives = Get-CimInstance Win32_DiskDrive

    Write-Host "System Hardware Information"
    Write-Host "---------------------------"
    Write-Host "Manufacturer: $($computerSystem.Manufacturer)"
    Write-Host "Model: $($computerSystem.Model)"
    Write-Host "Operating System: $($operatingSystem.Caption) $($operatingSystem.Version)"
    Write-Host "Processor: $($processor.Description)"
    Write-Host "Processor Speed: $($processor.MaxClockSpeed) MHz"
    Write-Host "Number of Cores: $($processor.NumberOfCores)"


    Write-Host "`nMemory Information"
    Write-Host "------------------"
    $memoryTable = @()
    foreach ($memory in $physicalMemory) {
        $memoryTable += [PSCustomObject]@{
            Vendor = $memory.Manufacturer
            Description = $memory.Description
            Size = "{0:N2} GB" -f ($memory.Capacity / 1GB)
            BankSlot = $memory.BankLabel
        }
    }
    $memoryTable | Format-Table -AutoSize


    Write-Host "`nDisk Information"
    Write-Host "----------------"
    $diskTable = @()
    foreach ($disk in $diskDrives) {
        $partitions = $disk | Get-CimAssociatedInstance -ResultClassName CIM_DiskPartition
        foreach ($partition in $partitions) {
            $logicalDisks = $partition | Get-CimAssociatedInstance -ResultClassName CIM_LogicalDisk
            foreach ($logicalDisk in $logicalDisks) {
                $diskTable += [PSCustomObject]@{
                    Manufacturer = $disk.Manufacturer
                    Location = $partition.DeviceID
                    Drive = $logicalDisk.DeviceID
                    SizeGB = [math]::Round($logicalDisk.Size / 1GB, 2)
                }
            }
        }
    }
    $diskTable | Format-Table -AutoSize


    Write-Host "`nNetwork Adapter Configuration"
    Write-Host "-------------------------------"


    Write-Host "`nVideo Card Information"
    Write-Host "----------------------"
    $videoControllers = Get-CimInstance Win32_VideoController
    foreach ($controller in $videoControllers) {
        Write-Host "Vendor: $($controller.VideoProcessor)"
        Write-Host "Description: $($controller.Description)"
        Write-Host "Resolution: $($controller.CurrentHorizontalResolution) x $($controller.CurrentVerticalResolution)"
    }


}

Get-SystemInfo
