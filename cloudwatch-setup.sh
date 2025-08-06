#!/bin/bash

# Variables
INSTANCE_ID="i-058ef39f9404f40e5"  # Replace with your actual EC2 instance ID
ALARM_NAME="HighCPUAlarm"
THRESHOLD=70

# Create a CloudWatch alarm for CPU utilization
aws cloudwatch put-metric-alarm \
  --alarm-name $ALARM_NAME \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold $THRESHOLD \
  --comparison-operator GreaterThanThreshold \
  --dimension Name=InstanceId,Value=$INSTANCE_ID \
  --evaluation-periods 2 \
  --alarm-actions "" \
  --unit Percent

echo "✅ CloudWatch alarm '$ALARM_NAME' created for instance $INSTANCE_ID."
