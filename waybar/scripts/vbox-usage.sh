#!/bin/bash

# VirtualBox resource usage script for Waybar
# Shows CPU and RAM usage of running VirtualBox VMs

# Check if VirtualBox is installed
if ! command -v VBoxManage &> /dev/null; then
    echo "VBox N/A"
    exit 0
fi

# Get list of running VMs
running_vms=$(VBoxManage list runningvms 2>/dev/null | wc -l)

if [ "$running_vms" -eq 0 ]; then
    echo "0 VMs"
    exit 0
fi

# Initialize counters
total_cpu=0
total_mem=0

# Get metrics for each running VM
while IFS= read -r vm; do
    # Extract VM name
    vm_name=$(echo "$vm" | sed 's/"\(.*\)".*/\1/')
    
    # Get VM metrics using VBoxManage metrics query
    # CPU usage (percentage)
    cpu=$(VBoxManage metrics query "$vm_name" CPU/Load/User 2>/dev/null | grep -oP '(?<=: )\d+' | tail -1)
    
    # Memory usage (MB)
    mem=$(VBoxManage showvminfo "$vm_name" --machinereadable 2>/dev/null | grep "^memory=" | cut -d'=' -f2)
    
    # Add to totals (with fallback to 0 if values are empty)
    total_cpu=$((total_cpu + ${cpu:-0}))
    total_mem=$((total_mem + ${mem:-0}))
    
done < <(VBoxManage list runningvms 2>/dev/null)

# Format memory (convert MB to GB if over 1024MB)
if [ "$total_mem" -ge 1024 ]; then
    mem_gb=$(awk "BEGIN {printf \"%.1f\", $total_mem/1024}")
    mem_display="${mem_gb}GB"
else
    mem_display="${total_mem}MB"
fi

# Output format: "X VMs • CPU% • Memory"
if [ "$running_vms" -eq 1 ]; then
    echo "$running_vms VM • ${total_cpu}% • ${mem_display}"
else
    echo "$running_vms VMs • ${total_cpu}% • ${mem_display}"
fi

# Tooltip could show individual VM details (optional enhancement)
# For now, we just show aggregated stats
