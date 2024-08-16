#!/bin/bash

# Path to your Go binary
BINARY_PATH="/workspace/myservice"

# Ensure the binary exists
if [ ! -f "$BINARY_PATH" ]; then
  echo "Error: Binary not found at $BINARY_PATH"
  exit 1
fi

# Copy the binary to the EC2 instance
scp -o StrictHostKeyChecking=no "$BINARY_PATH" ec2-user@$EC2_PUBLIC_IP:/home/ec2-user/myservice

# Execute commands on the EC2 instance
ssh -o StrictHostKeyChecking=no ec2-user@$EC2_PUBLIC_IP << 'ENDSSH'
  sudo mv /home/ec2-user/myservice /usr/local/bin/myservice
  sudo systemctl restart myservice || (sudo systemctl start myservice)
ENDSSH
