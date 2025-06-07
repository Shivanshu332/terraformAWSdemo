#!/bin/bash

# Update the system
yum update -y

# Install Apache (httpd)
yum install -y httpd

# Get the instance ID using the instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Install the AWS CLI
yum install -y aws-cli

# Define custom username and password
USERNAME="cadmin"
PASSWORD="1234"

# Create the new user and set the password
useradd -m -s /bin/bash "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd

# Grant sudo privileges (optional)
usermod -aG sudo "$USERNAME"

# Enable password authentication in SSH
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Restart SSH service to apply changes
systemctl restart sshd


# Ensure the web root directory exists
mkdir -p /var/www/html


# Create a simple HTML file with portfolio content
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>My Portfolio</title>
  <style>
    /* Add animation and styling for the text */
    @keyframes colorChange {
      0% { color: red; }
      50% { color: green; }
      100% { color: blue; }
    }
    h1 {
      animation: colorChange 2s infinite;
    }
  </style>
</head>
<body>
  <h1>Terraform Project Server 1</h1>
  <h2>Instance ID: <span style="color:green">$INSTANCE_ID</span></h2>
  <p>Welcome to Shivanshu's instance</p>
</body>
</html>
EOF

# Start and enable Apache on boot
systemctl start httpd
systemctl enable httpd
