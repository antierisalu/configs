#!/bin/bash

# Interface to monitor (e.g., wlp2s0 for Wi-Fi, eth0 for Ethernet)
INTERFACE="enp4"

# Function to get the current RX and TX bytes
get_bytes() {
    cat /proc/net/dev | grep "$INTERFACE" | awk '{print $2, $10}'
}

# Get current byte counts
read -r RX_BYTES TX_BYTES < <(get_bytes)

sleep 1

# Get new byte counts
read -r NEW_RX_BYTES NEW_TX_BYTES < <(get_bytes)

# Calculate the difference
RX_DIFF=$((NEW_RX_BYTES - RX_BYTES))
TX_DIFF=$((NEW_TX_BYTES - TX_BYTES))

# Convert to Mbit/s
RX_MBPS=$(awk "BEGIN {printf \"%.2f\", $RX_DIFF * 8 / 1024 / 1024}")Mbps
TX_MBPS=$(awk "BEGIN {printf \"%.2f\", $TX_DIFF * 8 / 1024 / 1024}")Mbps


# CPU
cpu_name=$(awk '/model name/ {print $NF}' /proc/cpuinfo | tail -n 1):
cpu_temp=$(cat /sys/class/thermal/thermal_zone1/temp | awk '{print $1/1000}')°C
cpu_free=$(top -bn1 | grep Cpu | awk '{print $8}')
cpu_usage=$(echo "100 - $cpu_free" | bc)
cpu_usage=${cpu_usage%.*}%

# RAM Usage in GB
ram_usage=$(free -m | grep Mem | awk '{printf "%.2f", ($3 / 1024)}')G
ram_total=$(free -m | grep Mem | awk '{printf "%.2f", ($2 / 1024)}')G

# GPU
if command -v nvidia-smi  &> /dev/null; then

	gpu_name=$(nvidia-smi --query-gpu=name --format=csv,noheader):
	gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)%
	gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)°C
	gpu_w=$(nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits)W
	gpu_mem=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)MiB
	#gpu_fan=$(nvidia-smi --query-gpu=fan.speed --format=csv,noheader)%

	GPU="$gpu_name $gpu_temp - $gpu_usage - $gpu_w - $gpu_mem |"
else
	GPU=""
fi

CPU="$cpu_name $cpu_temp - $cpu_usage |"
RAM="RAM: $ram_usage / $ram_total |"
NET="Network: $RX_MBPS ↓↑ $TX_MBPS |"
DATE=$(date +'%d-%m-%Y %T')

# Output the combined status
echo $CPU$RAM$GPU$NET$DATE
