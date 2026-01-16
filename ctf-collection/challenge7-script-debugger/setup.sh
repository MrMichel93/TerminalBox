#!/bin/bash

# Challenge 7: Script Debugger - Setup Script

echo "Setting up Challenge 7: Script Debugger..."

# Create a broken script with multiple errors
cat > broken_script.sh << 'EOF'
#!/bin/bash
# This script is broken! Fix all the errors to reveal the flag.

# Error 1: Missing quotes around string with spaces
MESSAGE=Welcome to the debugger challenge

# Error 2: Wrong variable syntax (missing $)
echo message

# Error 3: Incorrect comparison operator (= instead of -eq for numbers)
NUMBER=42
if [ $NUMBER = 42 ]; then
    echo "Number check passed"
fi

# Error 4: Missing quotes around variable in string comparison
STRING="test"
if [ $STRING = "test" ]; then
    echo "String check passed"
fi

# Error 5: Missing 'then' keyword
if [ -f "/etc/passwd" ]
    echo "File exists"
fi

# Error 6: Missing 'done' for loop
COUNTER=0
for i in 1 2 3
do
    COUNTER=$((COUNTER + 1))

# Error 7: Incorrect arithmetic syntax
RESULT=5+5
echo "Result: $RESULT"

# Error 8: Missing closing quote
echo "This string is not closed properly

# If all errors are fixed, reveal the flag
FLAG="FLAG{scr1pt_d3bugg1ng_m4st3r}"
echo "Congratulations! Here's your flag: $FLAG"
EOF

# Create a solution script for reference (hidden)
cat > .solution_script.sh << 'EOF'
#!/bin/bash
# This is the corrected version

MESSAGE="Welcome to the debugger challenge"
echo "$MESSAGE"

NUMBER=42
if [ $NUMBER -eq 42 ]; then
    echo "Number check passed"
fi

STRING="test"
if [ "$STRING" = "test" ]; then
    echo "String check passed"
fi

if [ -f "/etc/passwd" ]; then
    echo "File exists"
fi

COUNTER=0
for i in 1 2 3; do
    COUNTER=$((COUNTER + 1))
done

RESULT=$((5 + 5))
echo "Result: $RESULT"

echo "This string is closed properly"

FLAG="FLAG{scr1pt_d3bugg1ng_m4st3r}"
echo "Congratulations! Here's your flag: $FLAG"
EOF

chmod +x .solution_script.sh

echo "Setup complete!"
echo ""
echo "A broken script 'broken_script.sh' has been created."
echo ""
echo "Your mission: Fix all the errors in the script so it runs successfully."
echo ""
echo "To get started:"
echo "  1. View the script: cat broken_script.sh"
echo "  2. Try to run it: bash broken_script.sh"
echo "  3. Read error messages carefully"
echo "  4. Fix errors one at a time"
echo "  5. Test after each fix"
echo ""
echo "Helpful commands:"
echo "  bash broken_script.sh      # Run the script"
echo "  bash -x broken_script.sh   # Run with debug output"
echo "  bash -n broken_script.sh   # Check syntax without running"
echo ""
echo "Types of errors to look for:"
echo "  - Missing quotes"
echo "  - Wrong comparison operators"
echo "  - Missing keywords (then, fi, done)"
echo "  - Incorrect variable syntax"
echo "  - Unclosed strings"
echo "  - Wrong arithmetic syntax"
