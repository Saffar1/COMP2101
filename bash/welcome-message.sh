#!/bin/bash
#
# This script produces a dynamic welcome message.
# It should look like: "Welcome to planet hostname, title name!"

# Task 1: Use the variable $USER instead of the myname variable to get your name
name="$USER"

# Task 2: Dynamically generate the value for your hostname variable using the hostname command
hostName="$(hostname)"

# Task 3: Add the time and day of the week to the welcome message
currentTime="$(date +"%I:%M %p")"
currentDay="$(date +"%A")"
welcomeMessage="It is $currentDay at $currentTime."

# Task 4: Set the title using the day of the week
case "$currentDay" in
 "Monday")
    title="Optimist"
    ;;
  "Tuesday")
    title="Realist"
    ;;
  "Wednesday")
    title="Pessimist"
    ;;
  "Thursday")
    title="Dreamer"
    ;;
  "Friday")
    title="Adventurer"
    ;;
  "Saturday")
    title="Explorer"
    ;;
  "Sunday")
    title="Sundayer"
    ;;
  *)
    title="Unknown"
    ;;esac

# Display the welcome message with the dynamic values
echo "Welcome to planet $hostname, $title $name!"
echo "$welcomeMessage"
