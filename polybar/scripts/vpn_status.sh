#!/bin/bash

vpn_connected=$(ifconfig | grep "cscotun0\|tun0")
if [ ! -z "$vpn_connected" ]; then
echo "%{B#A3BE8C} S %{B-}"
else
echo "S"
fi
