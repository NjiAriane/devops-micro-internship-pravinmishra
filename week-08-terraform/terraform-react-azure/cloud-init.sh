#!/bin/bash

# Update the system
sudo apt update -y

# Install required packages
sudo apt install -y nodejs npm nginx git

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Clone the React application
cd /tmp
git clone https://github.com/pravinmishraaws/my-react-app.git

# Enter the React application
cd /tmp/my-react-app

# Update App.js with student information
cd src

cat > App.js <<'EOF'
import React from 'react';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>My React Application</h1>
        <h2>Deployed by: <strong>NJI ARIANE RUTH</strong></h2>
        <p>Date: <strong>03/09/2026</strong></p>
      </header>
    </div>
  );
}

export default App;
EOF

# Return to the React application directory
cd /tmp/my-react-app

# Install dependencies
npm install

# Build the React application
npm run build

# Remove default Nginx web files
sudo rm -rf /var/www/html/*

# Copy React production build to Nginx
sudo cp -r build/* /var/www/html/

# Set proper permissions
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

# Configure Nginx for the React single-page application
echo 'server {
    listen 80;
    server_name _;
    root /var/www/html;
    index index.html;

    location / {
        try_files $uri /index.html;
    }

    error_page 404 /index.html;
}' | sudo tee /etc/nginx/sites-available/default > /dev/null

# Test Nginx configuration
sudo nginx -t

# Restart Nginx
sudo systemctl restart nginx

# Display deployment completion message
echo "React application deployment completed successfully."
