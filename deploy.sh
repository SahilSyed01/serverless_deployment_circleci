#!/bin/bash

# Path to your Go binary (update to match the attached workspace)
BINARY_PATH="/workspace/myapp"

# Ensure the binary exists
if [ ! -f "$BINARY_PATH" ]; then
  echo "Error: Binary not found at $BINARY_PATH"
  exit 1
fi

# Decode the base64 encoded SSH key and save it as a file
echo "$EC2_SSH_KEY" | base64 --decode > /tmp/your-key.pem
chmod 600 /tmp/your-key.pem

# Copy the binary to the EC2 instance
scp -i /tmp/your-key.pem -o StrictHostKeyChecking=no "$BINARY_PATH" ec2-user@$EC2_PUBLIC_IP:/home/ec2-user/myservice

# Execute commands on the EC2 instance
ssh -i /tmp/your-key.pem -o StrictHostKeyChecking=no ec2-user@$EC2_PUBLIC_IP << 'ENDSSH'
  sudo mv /home/ec2-user/myservice /usr/local/bin/myservice
  sudo systemctl restart myservice || (sudo systemctl start myservice)
ENDSSH
