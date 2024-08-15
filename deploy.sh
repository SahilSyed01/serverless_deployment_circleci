#!/bin/bash

# Ensure that the SSH key is saved correctly
echo "$EC2_SSH_KEY" | tr -d '\r' | tee /tmp/your-key.pem > /dev/null
chmod 600 /tmp/your-key.pem

# Print the length of the SSH key file for debugging
echo "SSH key file length:"
wc -c < /tmp/your-key.pem

# Verify the format of the key file
file /tmp/your-key.pem

# Copy the binary to the EC2 instance
scp -i /tmp/your-key.pem -o StrictHostKeyChecking=no /workspace/myservice ec2-user@$EC2_PUBLIC_IP:/home/ec2-user/myservice

# Execute commands on the EC2 instance
ssh -i /tmp/your-key.pem -o StrictHostKeyChecking=no ec2-user@$EC2_PUBLIC_IP << 'ENDSSH'
  sudo mv /home/ec2-user/myservice /usr/local/bin/myservice
  sudo systemctl restart myservice || (sudo systemctl start myservice)
ENDSSH
