
#!/bin/bash
#
# This script implements a guessing game
# It will pick a secret number from 1 to 10
# It will then repeatedly ask the user to guess the number
# until the user gets it right

# Give the user instructions for the game
cat <<EOF
Let's play a game.
I will pick a secret number from 1 to 10 and you have to guess it.
If you get it right, you get a virtual prize.
Here we go!

EOF

# Pick the secret number and save it
secretnumber=$((RANDOM % 10 + 1)) # save our secret number to compare later

# This loop repeatedly asks the user to guess and tells them if they got the right answer
# TASK 1: Test the user input to make sure it is not blank
# TASK 2: Test the user input to make sure it is a number from 1 to 10 inclusive
# TASK 3: Tell the user if their guess is too low or too high after each incorrect guess

read -p "Give me a number from 1 to 10: " userguess # ask for a guess

# Task 1: Test if the user input is blank
while [ -z "$userguess" ]; do
  echo "Invalid input. Please enter a number from 1 to 10."
  read -p "Give me a number from 1 to 10: " userguess
done

# Task 2: Test if the user input is a number from 1 to 10
while ! [[ $userguess =~ ^[1-9]$|^10$ ]]; do
  echo "Invalid input. Please enter a number from 1 to 10."
  read -p "Give me a number from 1 to 10: " userguess
done

# Task 3: Tell the user if their guess is too low or too high after each incorrect guess
while [ "$userguess" -ne "$secretnumber" ]; do
  if [ "$userguess" -lt "$secretnumber" ]; then
    echo "Too low!"
  else
    echo "Too high!"
  fi

  read -p "Give me a number from 1 to 10: " userguess
done

echo "You got it! Have a milkdud."
