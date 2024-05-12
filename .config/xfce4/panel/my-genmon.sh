#!/bin/bash

# CPU stuff
cpuusage=$(top -bn 2 -d 0.2 | grep '^%Cpu' | tail -n 1 | awk '{print $2+$4+$6}')
cpuusage=$(printf "%.0f" "$cpuusage")

# RAM stuff
total=$(grep -e "^MemTotal" -m 1 /proc/meminfo | awk '{print $2}')
available=$(grep -e "^MemAvailable" -m 1 /proc/meminfo | awk '{print $2}')
memusage=$(echo "scale=2; (1-($available/$total))*100" | bc)
memusage=$(printf "%.0f" "$memusage")

echo "CPU: $cpuusage% RAM: $memusage% BAT: "
