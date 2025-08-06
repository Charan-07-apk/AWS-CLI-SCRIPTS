#!/bin/bash

# Variables
BUCKET_NAME="charan-s3-bucket-$(date +%s)" # Ensures unique bucket name
REGION="ap-south-1" # Update this if needed

# 1. Create the bucket
aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION --create-bucket-configuration LocationConstraint=$REGION
echo "✅ Bucket '$BUCKET_NAME' created."

# 2. Enable versioning
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Enabled
echo "✅ Versioning enabled on '$BUCKET_NAME'."

# 3. Block public access
aws s3api put-public-access-block --bucket $BUCKET_NAME --public-access-block-configuration \
BlockPublicAcls=true \
IgnorePublicAcls=true \
BlockPublicPolicy=true \
RestrictPublicBuckets=true
echo "✅ Public access blocked on '$BUCKET_NAME'."
