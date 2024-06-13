#!/bin/bash

# CPU stuff
cpuusage=$(top -bn 2 -d 0.2 | grep '^%Cpu' | tail -n 1 | awk '{print $2+$4+$6}')
cpuusage=$(printf "%.0f" "$cpuusage")

cputemp=$(sensors | grep 'amdgpu-pci-0300' -A 5 | grep 'edge' | awk '{print $2}' | sed 's/+//')
cputemp=$(printf "%.0f" "$cputemp")


# RAM stuff
total=$(grep -e "^MemTotal" -m 1 /proc/meminfo | awk '{print $2}')
available=$(grep -e "^MemAvailable" -m 1 /proc/meminfo | awk '{print $2}')
memusage=$(echo "scale=2; (1-($available/$total))*100" | bc)
memusage=$(printf "%.0f" "$memusage")

echo "CPU:$cpuusage% $cputemp°C RAM:$memusage% BAT:"
