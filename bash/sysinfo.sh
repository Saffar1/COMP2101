#!/bin/bash

fqdn=$(hostname)
echo "Fully-Qualified Domain Name (FQDN): $fqdn"

os_info=$(hostnamectl | grep "Operating System")
echo "$os_info"

ip_addresses=$(hostname -I | grep -v '^127')
echo "IP Addresses: $ip_addresses"

root_space=$(df -h / | awk 'NR==2{print $4}')
echo "Root Filesystem Space Available: $root_space"

