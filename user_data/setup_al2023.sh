#!/bin/bash
# Amazon Linux 2023 Web Server Setup
set -e
exec > >(tee /var/log/user-data.log) 2>&1

echo "=== Starting User Data Script ==="

# Update system and install Apache
dnf update -y
dnf install -y httpd

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Get instance metadata
INSTANCE_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
TIMESTAMP=$(date)

# Create HTML page with real values
cat > /var/www/html/index.html << HTML
<!DOCTYPE html>
<html>
<head>
    <title>Terraform AWS EC2</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 40px; 
            background: #f0f8ff;
        }
        .container { 
            max-width: 600px; 
            margin: 0 auto; 
            background: white; 
            padding: 30px; 
            border-radius: 10px; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .success { 
            color: green; 
            font-size: 24px; 
            margin-bottom: 20px;
        }
        .info {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin: 15px 0;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success">✅ SUCCESS!</div>
        <h1>Terraform + AWS EC2</h1>
        <p>Your web server is running on Amazon Linux 2023!</p>
        
        <div class="info">
            <p><strong>Instance IP:</strong> $INSTANCE_IP</p>
            <p><strong>Deployed:</strong> $TIMESTAMP</p>
            <p><strong>Hostname:</strong> $(hostname)</p>
            <p><strong>Instance Type:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-type)</p>
        </div>
        
        <hr>
        <p><em>Deployed automatically with Terraform User Data</em></p>
    </div>
</body>
</html>
HTML

# Set proper permissions
chown -R apache:apache /var/www/html

# Test that Apache is working
if curl -s http://localhost > /dev/null; then
    echo "✅ Apache is serving content successfully"
    echo "✅ Web server accessible at: http://$INSTANCE_IP"
else
    echo "❌ Apache is not responding"
    exit 1
fi

echo "=== User Data Script Completed Successfully ==="
