#!/bin/bash

################
# Data Gathering
################
# the first part is run once to get information about the host
# grep is used to filter ip command output so we don't have extra junk in our output
# stream editing with sed and awk are used to extract only the data we want displayed

# Variables
verbose="no"
interface=""

#####
# Once per host report
#####
while [ "$1" != "" ]; do
  case $1 in
    -v )
      verbose="yes"
      ;;
    * )
      interface=$1
      ;;
  esac
  shift
done

[ "$verbose" = "yes" ] && echo "Gathering host information"

# Hostname and IP address
my_hostname="$(hostname) / $(hostname -I)"

[ "$verbose" = "yes" ] && echo "Identifying default route"

# Default router information
default_router_address=$(ip r s default| awk '{print $3}')
default_router_name=$(getent hosts $default_router_address|awk '{print $2}')

[ "$verbose" = "yes" ] && echo "Checking for external IP address and hostname"

# External IP address and name
external_address=$(curl -s icanhazip.com)
external_name=$(getent hosts $external_address | awk '{print $2}')

cat <<EOF

System Identification Summary
=============================
Hostname      : $my_hostname
Default Router: $default_router_address
Router Name   : $default_router_name
External IP   : $external_address
External Name : $external_name

EOF

#####
# End of Once per host report
#####

# Per-interface report
if [ -n "$interface" ]; then
  cat <<EOF

Interface $interface:
===============

EOF

  [ "$verbose" = "yes" ] && echo "Getting IPV4 address and name for interface $interface"

  # Find an address and hostname for the interface being summarized
  ipv4_address=$(ip a s $interface|awk -F '[/ ]+' '/inet /{print $3}')
  ipv4_hostname=$(getent hosts $ipv4_address | awk '{print $2}')

  [ "$verbose" = "yes" ] && echo "Getting IPV4 network block info and name for interface $interface"

  # Identify the network number for this interface and its name if it has one
  network_address=$(ip route list dev $interface scope link|cut -d ' ' -f 1)
  network_number=$(cut -d / -f 1 <<<"$network_address")
  network_name=$(getent networks $network_number|awk '{print $1}')

  cat <<EOF
Address         : $ipv4_address
Name            : $ipv4_hostname
Network Address : $network_address
Network Name    : $network_name

EOF
fi
