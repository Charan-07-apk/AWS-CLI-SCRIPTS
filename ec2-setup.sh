#!/bin/bash

# Variables
KEY_NAME="my-key"
SECURITY_GROUP="my-sg"
INSTANCE_NAME="my-ec2-instance"

# 1. Create a Key Pair
aws ec2 create-key-pair --key-name $KEY_NAME --query 'KeyMaterial' --output text > ${KEY_NAME}.pem
chmod 400 ${KEY_NAME}.pem
echo "✅ Key pair '$KEY_NAME' created."

# 2. Create Security Group
SECURITY_GROUP_ID=$(aws ec2 create-security-group \
  --group-name $SECURITY_GROUP \
  --description "My security group" \
  --query 'GroupId' \
  --output text)
echo "✅ Security group '$SECURITY_GROUP' created with ID: $SECURITY_GROUP_ID"

# Add inbound rule for SSH
aws ec2 authorize-security-group-ingress \
  --group-id $SECURITY_GROUP_ID \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0

# 3. Launch EC2 Instance
aws ec2 run-instances \
  --image-id ami-0c02fb55956c7d316 \
  --instance-type t2.micro \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP_ID \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
  --count 1
echo "✅ EC2 instance launched."
