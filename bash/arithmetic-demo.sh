#!/bin/bash
#
# This script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables.
# Use one or more read commands to get 3 numbers from the user.

read -p "Enter the first number: " numOne
read -p "Enter the second number: " numTwo
read -p "Enter the third number: " numThree

# Task 2: Change the output to only show the sum and product of the 3 numbers with labels.

sum=$((numOne + numTwo + numThree))
product=$((numOne * numTwo * numThree))

cat <<EOF
The sum of the three numbers is: $sum
The product of the three numbers is: $product
EOF
