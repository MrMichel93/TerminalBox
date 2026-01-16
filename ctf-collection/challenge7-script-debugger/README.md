# Challenge 7: Script Debugger

**Difficulty:** Hard  
**Skills:** Shell scripting, debugging, bash, syntax errors, logic errors, script analysis

## Challenge Description

You've been given a broken shell script that's supposed to reveal the flag when it runs successfully. However, the script contains multiple syntax and logic errors that prevent it from working. Your job is to debug and fix the script so it runs correctly and reveals the flag.

## Objective

Debug the broken script and run it successfully to get the flag. The flag format is: `FLAG{...}`

## Setup

The challenge environment is automatically loaded when you enter this directory.
You'll find a `broken_script.sh` file that you need to fix.

## Hints

<details>
<summary>Hint 1 (Click to reveal)</summary>

Run the script and read the error messages carefully. They usually point to the line with the problem.
</details>

<details>
<summary>Hint 2 (Click to reveal)</summary>

Check for common issues: missing quotes, incorrect variable syntax, wrong comparison operators, missing `fi`/`done`, etc.
</details>

<details>
<summary>Hint 3 (Click to reveal)</summary>

Use `bash -x script.sh` to run in debug mode and see what's being executed.
</details>

<details>
<summary>Solution (Click to reveal)</summary>

The broken script has several issues:
1. Missing shebang or incorrect variable usage
2. Syntax errors in conditions or loops
3. Missing quotes around strings
4. Incorrect comparison operators
5. Missing closing statements

Fix each error, then run: `bash broken_script.sh`
</details>

## Cheat Sheet

### Running Scripts

```bash
# Run script
bash script.sh
./script.sh  # (needs execute permission)

# Run with debug output
bash -x script.sh

# Check syntax without running
bash -n script.sh

# Run in verbose mode
bash -v script.sh

# Run with both verbose and debug
bash -xv script.sh

# Make script executable
chmod +x script.sh
```

### Script Basics

```bash
#!/bin/bash
# Shebang - tells system which interpreter to use

# Variables
NAME="value"
NUMBER=42

# Use variables
echo $NAME
echo ${NAME}  # Preferred for clarity

# Command substitution
OUTPUT=$(command)
OUTPUT=`command`  # Old style

# Arithmetic
RESULT=$((5 + 3))
RESULT=$((NUMBER * 2))

# Read user input
read -p "Enter name: " USERNAME
```

### Conditional Statements

```bash
# If statement
if [ condition ]; then
    commands
fi

# If-else
if [ condition ]; then
    commands
else
    commands
fi

# If-elif-else
if [ condition1 ]; then
    commands
elif [ condition2 ]; then
    commands
else
    commands
fi

# String comparisons
[ "$str1" = "$str2" ]   # Equal
[ "$str1" != "$str2" ]  # Not equal
[ -z "$str" ]           # Empty string
[ -n "$str" ]           # Not empty

# Numeric comparisons
[ $a -eq $b ]  # Equal
[ $a -ne $b ]  # Not equal
[ $a -gt $b ]  # Greater than
[ $a -lt $b ]  # Less than
[ $a -ge $b ]  # Greater or equal
[ $a -le $b ]  # Less or equal

# File tests
[ -f file ]    # File exists
[ -d dir ]     # Directory exists
[ -r file ]    # Readable
[ -w file ]    # Writable
[ -x file ]    # Executable
[ -s file ]    # Not empty

# Logical operators
[ condition1 ] && [ condition2 ]  # AND
[ condition1 ] || [ condition2 ]  # OR
[ ! condition ]                   # NOT

# Modern syntax (bash)
[[ condition ]]
[[ $str == pattern ]]
[[ $str =~ regex ]]
```

### Loops

```bash
# For loop
for i in 1 2 3 4 5; do
    echo $i
done

# For loop with range
for i in {1..10}; do
    echo $i
done

# For loop with command output
for file in $(ls); do
    echo $file
done

# C-style for loop
for ((i=1; i<=10; i++)); do
    echo $i
done

# While loop
counter=1
while [ $counter -le 10 ]; do
    echo $counter
    counter=$((counter + 1))
done

# Until loop
counter=1
until [ $counter -gt 10 ]; do
    echo $counter
    counter=$((counter + 1))
done

# Read file line by line
while IFS= read -r line; do
    echo "$line"
done < file.txt

# Loop control
break      # Exit loop
continue   # Skip to next iteration
```

### Functions

```bash
# Define function
function_name() {
    commands
    return 0
}

# Call function
function_name

# Function with arguments
greet() {
    echo "Hello, $1!"
}
greet "World"

# Return value
add() {
    result=$(($1 + $2))
    echo $result
}
sum=$(add 5 3)

# Local variables
my_func() {
    local var="local value"
    echo $var
}
```

### Common Errors and Fixes

```bash
# Missing quotes
BAD:  [ $var = value ]
GOOD: [ "$var" = "value" ]

# Wrong comparison operator
BAD:  [ $num = 5 ]       # String comparison
GOOD: [ $num -eq 5 ]     # Numeric comparison

# Missing spaces in conditions
BAD:  [$var -eq 5]
GOOD: [ $var -eq 5 ]

# Missing $ for variables
BAD:  if [ var -eq 5 ]
GOOD: if [ $var -eq 5 ]

# Missing closing statement
BAD:  if [ condition ]; then
          commands
GOOD: if [ condition ]; then
          commands
      fi

# Unquoted strings with spaces
BAD:  FILE=my file.txt
GOOD: FILE="my file.txt"

# Command substitution issues
BAD:  OUTPUT='command'   # Wrong quotes
GOOD: OUTPUT=$(command)  # Correct
```

### Debugging Techniques

```bash
# Enable debug mode
set -x

# Disable debug mode
set +x

# Exit on error
set -e

# Exit on undefined variable
set -u

# Combine options
set -euxo pipefail

# Print debug info
echo "Debug: var=$var"

# Conditional debugging
DEBUG=1
[ $DEBUG -eq 1 ] && echo "Debug: at line $LINENO"

# Check if variable is set
echo "VAR=${VAR:-not set}"

# Print stack trace
caller
```

### Best Practices

```bash
# Always use shebang
#!/bin/bash

# Quote variables
"$var" instead of $var

# Use $() instead of backticks
$(command) instead of `command`

# Check command success
if command; then
    echo "Success"
else
    echo "Failed"
fi

# Use [[ ]] instead of [ ]
[[ condition ]] (in bash)

# Make scripts readable
# Add comments
# Use meaningful variable names
# Indent properly

# Handle errors
command || { echo "Command failed"; exit 1; }

# Validate input
if [ -z "$1" ]; then
    echo "Usage: $0 <argument>"
    exit 1
fi
```

### Script Structure

```bash
#!/bin/bash
# Script description
# Author: Name
# Date: YYYY-MM-DD

# Strict mode
set -euo pipefail

# Global variables
readonly CONST_VAR="value"
CONFIG_FILE="config.txt"

# Functions
usage() {
    echo "Usage: $0 [options]"
    exit 1
}

main() {
    # Main logic here
    echo "Running main function"
}

# Parse arguments
while getopts "h" opt; do
    case $opt in
        h) usage ;;
        *) usage ;;
    esac
done

# Run main function
main "$@"
```

### Testing Scripts

```bash
# Dry run (syntax check)
bash -n script.sh

# Run with error checking
bash -e script.sh

# Test specific functions
source script.sh
function_name args

# Use shellcheck (if installed)
shellcheck script.sh

# Add test cases
test_addition() {
    result=$(add 2 3)
    [ $result -eq 5 ] && echo "PASS" || echo "FAIL"
}
```

### Useful Commands

```bash
# Exit status of last command
echo $?

# Process ID of script
echo $$

# All arguments
echo $@

# Number of arguments
echo $#

# Script name
echo $0

# Current line number
echo $LINENO

# Random number
echo $RANDOM

# Current working directory
pwd

# Script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
```

## What You Learned

After completing this challenge, you should understand:
- How to read and interpret bash error messages
- Common shell script syntax errors
- Debugging techniques for shell scripts
- Proper variable usage and quoting
- Conditional statements and loops in bash
- How to test and validate scripts
- Best practices for shell scripting
- Using debug mode (-x flag)

---

**Previous Challenge:** [Challenge 6: Archive Archaeology](../challenge6-archive-archaeology/)  
**Next Challenge:** [Challenge 8: System Intrusion Analysis](../challenge8-intrusion-analysis/)
