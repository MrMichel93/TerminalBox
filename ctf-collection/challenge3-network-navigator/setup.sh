#!/bin/bash

# Challenge 3: Network Navigator - Setup Script

echo "Setting up Challenge 3: Network Navigator..."

# Create network configuration file
cat > network_config.txt << 'EOF'
# Network Configuration File
# Server Configuration Details

[Server Information]
Hostname: challenge-server
IP Address: 127.0.0.1
Region: localhost

[Connection Details]
Primary Port: 8888
Protocol: HTTP
Endpoint URL: http://localhost:8888/flag.txt

[Database]
Host: 127.0.0.1
Port: 3306
Type: MySQL

[Additional Notes]
- Check the endpoint URL for the flag
- Use curl or wget to retrieve data
- Server is running locally

EOF

# Create a temporary directory for the web server
mkdir -p /tmp/challenge3_webserver_$$

# Create the flag file
echo "FLAG{n3tw0rk_n1nj4_m4st3r}" > /tmp/challenge3_webserver_$$/flag.txt

# Create an index page
cat > /tmp/challenge3_webserver_$$/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head><title>Challenge Server</title></head>
<body>
<h1>Welcome to the Challenge Server</h1>
<p>The flag is in flag.txt</p>
</body>
</html>
EOF

# Start a simple Python HTTP server in the background
cd /tmp/challenge3_webserver_$$
python3 -m http.server 8888 > /dev/null 2>&1 &
SERVER_PID=$!

# Save the PID for cleanup
echo $SERVER_PID > /tmp/challenge3_server_pid_$$

echo "Setup complete!"
echo ""
echo "A web server has been started on http://localhost:8888"
echo "Check the 'network_config.txt' file for details."
echo ""
echo "Your mission: Analyze the network configuration and retrieve the flag."
echo ""
echo "When finished, stop the server with:"
echo "  kill $SERVER_PID"
echo ""
echo "Or run:"
echo "  pkill -f 'http.server 8888'"
