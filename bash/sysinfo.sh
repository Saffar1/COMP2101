#!/bin/bash

# Display the fully-qualified domain name (FQDN)
fqdn=$(hostname)
echo "Fully-Qualified Domain Name (FQDN): $fqdn"

# Display the operating system name and version
osInfo=$(hostnamectl)
osName=$(echo "$osInfo" | awk -F ": " '/Operating System/ {print $2}')
osVersion=$(echo "$osInfo" | awk -F ": " '/Kernel/ {print $2}')
echo "Operating System: $osName"
echo "Operating System Version: $osVersion"

# Display IP addresses (excluding 127.0.0.1)
ipAddresses=$(hostname -I | awk '{print $1}')
echo "IP Addresses:"
for ip in $ipAddresses; do
  if [[ $ip != 127.* ]]; then
    echo "- $ip"
  fi
done



#######################
# Check root privilege
#######################

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

################
# Data Gathering
################

# System Description
system_manufacturer=$(dmidecode -s system-manufacturer)
system_product_name=$(dmidecode -s system-product-name)
system_serial_number=$(dmidecode -s system-serial-number)

# CPU Information
cpu_info=$(lshw -class processor)
cpu_count=$(echo "$cpu_info" | grep -c "product:")
cpu_manufacturer=$(echo "$cpu_info" | awk -F ": " '/vendor:/ {print $2}' | head -n 1)
cpu_model=$(echo "$cpu_info" | awk -F ": " '/product:/ {print $2}' | head -n 1)
cpu_architecture=$(lscpu | awk -F ": " '/Architecture:/ {print $2}')
cpu_core_count=$(lscpu | awk -F ": " '/Core\(s\) per socket:/ {print $2}')
cpu_max_speed=$(lscpu | awk -F ": " '/CPU MHz:/ {print $2}')
cpu_max_speed=$(printf "%.2f GHz" $(bc <<<"scale=2;$cpu_max_speed/1000"))

# Cache Sizes
cache_sizes=$(lscpu | awk -F ": " '/L[1-3] cache:/ {print $2}')
cache_sizes=$(echo "$cache_sizes" | awk '{printf "%.2f MB\n", $1/1024}')

# Operating System Information
distro_name=$(lsb_release -s -d)
distro_version=$(lsb_release -s -r)

# RAM Information
ram_info=$(lshw -class memory)
total_ram=$(echo "$ram_info" | awk '/size:/ {sum+=$2} END{printf "%.2f GB\n", sum/1024/1024/1024}')
ram_table=$(echo "$ram_info" | awk -F ": " '/description:/ {desc=$2} /size:/ {size=$2; speed=$3} /physical id:/ {phy_id=$2} /slot:/ {slot=$2} {if (desc && size && speed && phy_id && slot) {printf "%-15s %-15s %-15s %-15s %-15s\n", desc, size, speed, phy_id, slot; desc=""; size=""; speed=""; phy_id=""; slot=""}}')

# Disk Storage Information
disk_info=$(lsblk -bo MODEL,SERIAL,SIZE,NAME,MOUNTPOINT,FSTYPE)
disk_table=$(echo "$disk_info" | awk '{printf "%-15s %-15s %-15s %-15s %-15s %-15s\n", $1, $2, $3, $4, $5, $6}')

################
# Report Sections
################

# System Description
echo "System Description"
echo "=================="
echo "Manufacturer     : $system_manufacturer"
echo "Product Name     : $system_product_name"
echo "Serial Number    : $system_serial_number"
echo

# CPU Information
echo "CPU Information"
echo "==============="
echo "Manufacturer     : $cpu_manufacturer"
echo "Model            : $cpu_model"
echo "Architecture     : $cpu_architecture"
echo "Core Count       : $cpu_core_count"
echo "Max Speed        : $cpu_max_speed"
echo "Cache Sizes      :"
echo "$cache_sizes"
echo

# Operating System Information
echo "Operating System Information"
echo "============================"
echo "Distro           : $distro_name"
echo "Version          : $distro_version"
echo

# RAM Information
echo "RAM Information"
echo "==============="
echo "Installed RAM    :"
echo "$ram_table"
echo "Total Size       : $total_ram"
echo

# Disk Storage Information
echo "Disk Storage Information"
echo "========================"
echo "Installed Disks  :"
echo "$disk_table"
echo

exit 0
