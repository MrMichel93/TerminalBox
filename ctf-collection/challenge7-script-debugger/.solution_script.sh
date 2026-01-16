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
