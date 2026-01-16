#!/bin/bash

# Challenge 2: Process Detective - Setup Script

echo "Setting up Challenge 2: Process Detective..."

# Create a script that will run as a background process
cat > /tmp/secret_process_$$.sh << 'EOF'
#!/bin/bash
# This is a secret process containing: FLAG{pr0c3ss_m4st3r_d3t3ct1v3}
while true; do
    sleep 60
done
EOF

chmod +x /tmp/secret_process_$$.sh

# Start the background process
nohup /tmp/secret_process_$$.sh > /dev/null 2>&1 &
PID=$!

echo "Setup complete!"
echo ""
echo "A secret process has been started in the background."
echo "Your mission: Find the process and extract the flag from it."
echo ""
echo "Hint: The process has 'secret' in its name."
echo "Use commands like 'ps', 'pgrep', and 'grep' to investigate."
echo ""
echo "When you're done, you can stop the process with:"
echo "  kill $PID"
echo "  or: pkill -f secret_process"
