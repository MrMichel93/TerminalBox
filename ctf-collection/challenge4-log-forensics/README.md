# Challenge 4: Log File Forensics

**Difficulty:** Medium  
**Skills:** Log analysis, grep, awk, sed, text processing, regex

## Challenge Description

A system administrator has left behind a massive log file from a web server. Hidden within thousands of log entries is a suspicious request that contains the flag. Your job is to analyze the log file, identify patterns, and extract the flag using text processing tools.

## Objective

Analyze the log file and find the flag. The flag format is: `FLAG{...}`

## Setup

Run the setup script:
```bash
bash setup.sh
```

This will generate a large log file with the flag hidden inside.

## Hints

<details>
<summary>Hint 1 (Click to reveal)</summary>

Use `grep` to search for patterns in the log file. Try searching for "FLAG".
</details>

<details>
<summary>Hint 2 (Click to reveal)</summary>

The flag might be in a suspicious user agent or URL parameter.
</details>

<details>
<summary>Hint 3 (Click to reveal)</summary>

Try: `grep -i "flag" access.log`
</details>

<details>
<summary>Solution (Click to reveal)</summary>

```bash
# Search for the flag pattern
grep "FLAG{" access.log

# Or search case-insensitively
grep -i "flag{" access.log

# Extract just the flag
grep -oP 'FLAG\{[^}]+\}' access.log
```
</details>

## Cheat Sheet

### Searching with grep

```bash
# Search for pattern in file
grep "pattern" filename

# Case-insensitive search
grep -i "pattern" filename

# Search recursively in directory
grep -r "pattern" directory/

# Show line numbers
grep -n "pattern" filename

# Show lines that DON'T match
grep -v "pattern" filename

# Count matching lines
grep -c "pattern" filename

# Show only matching part
grep -o "pattern" filename

# Show context (lines before and after)
grep -C 3 "pattern" filename
grep -A 3 "pattern" filename  # After
grep -B 3 "pattern" filename  # Before

# Search multiple files
grep "pattern" file1 file2

# Use regular expressions
grep -E "pattern1|pattern2" filename
egrep "pattern1|pattern2" filename

# Perl-compatible regex
grep -P "regex" filename
```

### Text Processing with awk

```bash
# Print specific column (space-delimited)
awk '{print $1}' filename

# Print multiple columns
awk '{print $1, $3}' filename

# Use different delimiter
awk -F: '{print $1}' filename

# Print lines matching pattern
awk '/pattern/ {print}' filename

# Print if column matches condition
awk '$3 > 100' filename

# Count lines
awk 'END {print NR}' filename

# Sum a column
awk '{sum += $1} END {print sum}' filename

# Print with custom output
awk '{print "User:", $1, "Value:", $2}' filename
```

### Text Processing with sed

```bash
# Replace first occurrence per line
sed 's/old/new/' filename

# Replace all occurrences
sed 's/old/new/g' filename

# Replace and save to file (in-place)
sed -i 's/old/new/g' filename

# Delete lines matching pattern
sed '/pattern/d' filename

# Print only matching lines
sed -n '/pattern/p' filename

# Delete empty lines
sed '/^$/d' filename

# Print specific line numbers
sed -n '10,20p' filename

# Replace in specific lines
sed '1,10s/old/new/g' filename
```

### Sorting and Counting

```bash
# Sort lines alphabetically
sort filename

# Sort numerically
sort -n filename

# Sort in reverse
sort -r filename

# Sort by column
sort -k 2 filename

# Sort and remove duplicates
sort -u filename

# Count unique lines
sort | uniq -c

# Show only duplicates
sort | uniq -d

# Show only unique lines
sort | uniq -u
```

### Advanced Text Processing

```bash
# Cut specific columns
cut -d: -f1 filename       # First field, : delimiter
cut -d' ' -f1,3 filename   # Fields 1 and 3

# Translate characters
tr 'a-z' 'A-Z' < filename  # Lowercase to uppercase
tr -d '0-9' < filename     # Delete digits

# Word count
wc filename                # Lines, words, characters
wc -l filename            # Count lines only
wc -w filename            # Count words only

# Display column view
column -t filename

# Join lines
paste file1 file2

# Split file
split -l 1000 filename     # Split into 1000-line chunks
```

### Log Analysis Specific

```bash
# Get unique IP addresses from log
awk '{print $1}' access.log | sort | uniq

# Count requests per IP
awk '{print $1}' access.log | sort | uniq -c | sort -rn

# Find most common URLs
awk '{print $7}' access.log | sort | uniq -c | sort -rn | head

# Find 404 errors
grep " 404 " access.log

# Find errors (4xx and 5xx)
grep -E " (4[0-9]{2}|5[0-9]{2}) " access.log

# Count status codes
awk '{print $9}' access.log | sort | uniq -c | sort -rn

# Find requests in time range
awk '$4 >= "[01/Jan/2024:00:00:00" && $4 <= "[01/Jan/2024:23:59:59"' access.log

# Extract user agents
awk -F'"' '{print $6}' access.log | sort | uniq

# Find large responses
awk '$10 > 1000000' access.log
```

### Regular Expressions

```bash
# Match any character
.

# Match start of line
^pattern

# Match end of line
pattern$

# Match zero or more
pattern*

# Match one or more
pattern+

# Match zero or one
pattern?

# Match specific number
pattern{3}      # Exactly 3
pattern{3,}     # 3 or more
pattern{3,5}    # Between 3 and 5

# Character classes
[abc]          # Any of a, b, or c
[a-z]          # Any lowercase letter
[0-9]          # Any digit
[^abc]         # Not a, b, or c

# Special characters
\d             # Digit
\w             # Word character
\s             # Whitespace
.              # Any character
```

### Combining Commands

```bash
# Pipe commands together
cat file | grep pattern | sort | uniq

# Save output to file
command > output.txt

# Append to file
command >> output.txt

# Redirect errors
command 2> errors.txt

# Redirect both stdout and stderr
command > output.txt 2>&1

# Use output as input
cat file | wc -l

# Tee output (save and display)
command | tee output.txt
```

### Performance Tips

```bash
# Search compressed files without extracting
zgrep "pattern" file.gz
zcat file.gz | grep "pattern"

# Process large files efficiently
# Use head/tail for samples
head -1000 large.log | grep pattern

# Process in chunks
split -l 10000 large.log chunk_
for file in chunk_*; do grep pattern $file; done

# Use parallel processing (if available)
cat large.log | parallel --pipe grep pattern
```

### Useful Tips

- **Pipe** (`|`) sends output of one command to another
- **Redirect** (`>`) sends output to a file
- **Append** (`>>`) adds output to end of file
- Use quotes around patterns with special characters
- Test regex patterns on small samples first
- Combine grep, awk, and sed for powerful processing

## What You Learned

After completing this challenge, you should understand:
- How to search and analyze log files
- Using grep with regular expressions
- Text processing with awk and sed
- Sorting and counting with sort and uniq
- Combining multiple commands with pipes
- Common log file formats and patterns

---

**Previous Challenge:** [Challenge 3: Network Navigator](../challenge3-network-navigator/)  
**Next Challenge:** [Challenge 5: Permission Puzzle](../challenge5-permission-puzzle/)
