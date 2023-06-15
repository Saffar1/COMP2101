#!/bin/bash
#
# This script rolls a pair of six-sided dice and displays both the rolls
#

# Task 1:
# Put the number of sides in a variable which is used as the range for the random number
# Put the bias, or minimum value for the generated number, in another variable
# Roll the dice using the variables for the range and bias, i.e., RANDOM % range + bias

# Task 2:
# Generate the sum of the dice
# Generate the average of the dice

# Display a summary of what was rolled, and the results of your arithmetic operations

# Number of sides for the dice
num_sides=6

# Bias or minimum value for the generated number
bias=1

# Tell the user we have started processing
echo "Rolling..."

# Roll the dice and save the results
die1=$(( RANDOM % num_sides + bias ))
die2=$(( RANDOM % num_sides + bias ))

# Generate the sum of the dice
sum=$(( die1 + die2 ))

# Generate the average of the dice
average=$(( (die1 + die2) / 2 ))

# Display the results and summary
echo "Rolled $die1, $die2"
echo "Sum: $sum"
echo "Average: $average"
