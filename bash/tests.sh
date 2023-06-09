#!/bin/bash
# This is a script to practice doing testing in bash scripts

# This section demonstrates file testing

# Test for the existence of the /etc/resolv.conf file
# TASK 1: Add a test to see if the /etc/resolv.conf file is a regular file
[ -f /etc/resolv.conf ] && echo "/etc/resolv.conf is a regular file" || echo "/etc/resolv.conf is not a regular file"

# TASK 2: Add a test to see if the /etc/resolv.conf file is a symbolic link
[ -L /etc/resolv.conf ] && echo "/etc/resolv.conf is a symbolic link" || echo "/etc/resolv.conf is not a symbolic link"

# TASK 3: Add a test to see if the /etc/resolv.conf file is a directory
[ -d /etc/resolv.conf ] && echo "/etc/resolv.conf is a directory" || echo "/etc/resolv.conf is not a directory"

# TASK 4: Add a test to see if the /etc/resolv.conf file is readable
[ -r /etc/resolv.conf ] && echo "/etc/resolv.conf is readable" || echo "/etc/resolv.conf is not readable"

# TASK 5: Add a test to see if the /etc/resolv.conf file is writable
[ -w /etc/resolv.conf ] && echo "/etc/resolv.conf is writable" || echo "/etc/resolv.conf is not writable"

# TASK 6: Add a test to see if the /etc/resolv.conf file is executable
[ -x /etc/resolv.conf ] && echo "/etc/resolv.conf is executable" || echo "/etc/resolv.conf is not executable"

# Tests if /tmp is a directory
# TASK 4: Add a test to see if the /tmp directory is readable
[ -r /tmp ] && echo "/tmp is readable" || echo "/tmp is not readable"

# TASK 5: Add a test to see if the /tmp directory is writable
[ -w /tmp ] && echo "/tmp is writable" || echo "/tmp is not writable"

# TASK 6: Add a test to see if the /tmp directory can be accessed
[ -x /tmp ] && echo "/tmp can be accessed" || echo "/tmp cannot be accessed"

# Tests if one file is newer than another
# TASK 7: Add testing to print out which file is newest or if they are the same age
[ /etc/hosts -nt /etc/resolv.conf ] && echo "/etc/hosts is newer than /etc/resolv.conf"
[ /etc/hosts -ot /etc/resolv.conf ] && echo "/etc/resolv.conf is newer than /etc/hosts"
[ ! /etc/hosts -nt /etc/resolv.conf -a ! /etc/hosts -ot /etc/resolv.conf ] && echo "/etc/hosts is the same age as /etc/resolv.conf"

# This section demonstrates doing numeric tests in bash

# TASK 1: Improve it by getting the user to give us the numbers to use in our tests
# TASK 2: Improve it by adding a test to tell the user if the numbers are even or odd
# TASK 3: Improve it by adding a test to tell the user if the second number is a multiple of the first number

read -p "Enter the first number: " firstNumber
read -p "Enter the second number: " secondNumber

[ $firstNumber -eq $secondNumber ] && echo "The two numbers are the same"
[ $firstNumber -ne $secondNumber ] && echo "The two numbers are not the same"

# TASK 2: Test if the first number is even or odd
if (( firstNumber % 2 == 0 )); then
    echo "The first number is even"
else
    echo "The first number is odd"
fi

# TASK 3: Test if the second number is a multiple of the first number
if (( secondNumber % firstNumber == 0 )); then
    echo "The second number is a multiple of the first number"
else
    echo "The second number is not a multiple of the first number"
fi

# This section demonstrates testing variables

# Test if the USER variable exists
# TASK 1: Add a command that prints out a labelled description of what is in the USER variable, but only if it is not empty
# TASK 2: Add a command that tells the user if the USER variable exists but is empty
[ -v USER ] && echo "The variable USER exists"
[ -n "$USER" ] && echo "The USER variable is not empty. It contains: $USER" || echo "The USER variable exists, but it is empty"

# Tests for string data
# TASK 3: Modify the command to use the != operator instead of the = operator, without breaking the logic of the command
# TASK 4: Use the read command to ask the user running the script to give us strings to use for the tests

read -p "Enter string a: " a
read -p "Enter string b: " b

[ "$a" != "$b" ] && echo "$a is not alphanumerically equal to $b" || echo "$a is alphanumerically equal to $b"
