#!/bin/bash

# Define the calculation to be performed
CALC=$(rofi -dmenu -p "Calculate")

# Perform the calculation and display the result
RESULT=$(echo "$CALC" | bc -l)
rofi -e "$RESULT"
