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
