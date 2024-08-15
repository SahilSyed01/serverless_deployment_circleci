#!/bin/bash

# Copy the binary to the EC2 instance
scp -i /tmp/your-key.pem -o StrictHostKeyChecking=no /workspace/myservice ec2-user@$EC2_PUBLIC_IP:/home/ec2-user/myservice

# Execute commands on the EC2 instance
ssh -i /tmp/your-key.pem -o StrictHostKeyChecking=no ec2-user@$EC2_PUBLIC_IP << 'ENDSSH'
  sudo mv /home/ec2-user/myservice /usr/local/bin/myservice
  sudo systemctl restart myservice || (sudo systemctl start myservice)
ENDSSH
