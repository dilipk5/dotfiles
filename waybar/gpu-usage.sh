#!/bin/bash
gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
echo "{\"text\": \"GPU ${gpu_usage}%\", \"tooltip\": \"GPU Usage\"}"

