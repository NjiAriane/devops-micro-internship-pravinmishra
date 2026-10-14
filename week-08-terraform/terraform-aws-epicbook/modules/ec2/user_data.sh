#!/bin/bash

set -e

# Update system packages
apt-get update -y
apt-get upgrade -y

# Install required packages
apt-get install -y \
  curl \
  git \
  nginx \
  mysql-client

# Install Node.js LTS using NodeSource
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt-get install -y nodejs

# Enable and start Nginx
systemctl enable nginx
systemctl start nginx

# Display installed versions in cloud-init logs
node --version
npm --version
git --version
nginx -v
mysql --version
curl --version