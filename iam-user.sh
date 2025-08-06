#!/bin/bash

IAM_USER_NAME="devops-user"

# 1. Create IAM user
aws iam create-user --user-name $IAM_USER_NAME
echo "✅ Created IAM user: $IAM_USER_NAME"

# 2. Attach AdministratorAccess policy
aws iam attach-user-policy --user-name $IAM_USER_NAME --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
echo "✅ Attached admin policy to $IAM_USER_NAME"

# 3. Create access key
aws iam create-access-key --user-name $IAM_USER_NAME
