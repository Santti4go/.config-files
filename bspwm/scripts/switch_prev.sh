#!/bin/bash

# Get the IDs of all the visible nodes on current desktop
nodes=$(bspc query -N -d)

# Get the ID of the currently focused node
current=$(bspc query -N -n)

# If the current node is not in the list of visible nodes, use the first node
if [[ ! $nodes =~ $current ]]; then
  target=$(echo "$nodes" | head -n 1)
else
  # Get the ID of the previously focused node
  previous=$(echo "$nodes" | grep -B1 "^$current$" | head -n 1)

  # If there is no previous node, use the last node
  if [[ -z $previous ]]; then
    target=$(echo "$nodes" | tail -n 1)
  else
    target=$previous
  fi
fi

PREV_FILE_PATH=~/.config/bspwm/scripts/.previous_node
previous=$(cat $PREV_FILE_PATH)
if [[ -z $previous ]]; then
previous=$(bspc query -N | tail -2 | head -1)  
fi
echo $current>$PREV_FILE_PATH

# Focus the target node
bspc node -f "$previous"
