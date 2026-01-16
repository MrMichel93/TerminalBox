# Challenge 1: Hidden Files Explorer

**Difficulty:** Easy  
**Skills:** File navigation, hidden files, basic commands

## Challenge Description

You've stumbled upon a mysterious directory structure. Your mission is to find the hidden flag that has been concealed somewhere in the file system. The flag is in a hidden file or directory, and you'll need to use your knowledge of Linux file systems to locate it.

## Objective

Find the hidden flag. The flag format is: `FLAG{...}`

## Setup

The challenge environment is automatically loaded when you enter this directory.
You'll find a `mystery_dir` directory with various files and hidden items.

## Hints

<details>
<summary>Hint 1 (Click to reveal)</summary>

Files and directories starting with a dot (.) are hidden in Linux. Regular `ls` won't show them.
</details>

<details>
<summary>Hint 2 (Click to reveal)</summary>

Try using `ls -a` or `ls -la` to show all files, including hidden ones.
</details>

<details>
<summary>Hint 3 (Click to reveal)</summary>

The flag might be nested in hidden directories. Use `find` or navigate through directories systematically.
</details>

<details>
<summary>Solution (Click to reveal)</summary>

```bash
# List all files including hidden ones
ls -la mystery_dir/

# Navigate into the hidden directory
cd mystery_dir/.secrets

# List files there
ls -la

# Check the hidden file
cat .hidden_treasure
```

The flag is in `mystery_dir/.secrets/.hidden_treasure`
</details>

## Cheat Sheet

### Listing Files and Directories

```bash
# List files in current directory
ls

# List with details (long format)
ls -l

# List all files including hidden ones
ls -a

# List all files with details
ls -la

# List all files with human-readable sizes
ls -lah

# List only hidden files
ls -d .*

# List files recursively
ls -R
```

### Finding Files

```bash
# Find all files in current directory and subdirectories
find .

# Find all files by name
find . -name "filename"

# Find all files by pattern
find . -name "*.txt"

# Find hidden files
find . -name ".*"

# Find directories only
find . -type d

# Find files only
find . -type f
```

### Navigating Directories

```bash
# Change directory
cd directory_name

# Go to parent directory
cd ..

# Go to home directory
cd ~
cd

# Go to previous directory
cd -

# Print current working directory
pwd
```

### Viewing File Contents

```bash
# Display file contents
cat filename

# Display with line numbers
cat -n filename

# Display first 10 lines
head filename

# Display last 10 lines
tail filename

# Display first N lines
head -n 20 filename

# View file interactively (use q to quit)
less filename
more filename
```

### File Information

```bash
# Get file type
file filename

# Get detailed file information
stat filename

# Get word, line, and character count
wc filename
```

### Useful Tips

- **Hidden files** in Linux start with a dot (.)
- **Current directory** is represented by `.`
- **Parent directory** is represented by `..`
- Use **Tab** key for auto-completion
- Use **Ctrl+C** to cancel a running command
- Use **Ctrl+L** or `clear` to clear the screen

### Common Mistakes to Avoid

1. Forgetting to use `-a` flag with `ls` to see hidden files
2. Not using quotes around file names with spaces
3. Confusing relative paths with absolute paths

## What You Learned

After completing this challenge, you should understand:
- How hidden files work in Linux
- Various ways to list files and directories
- How to navigate the file system
- Basic commands for viewing file contents
- Using the `find` command to search for files

---

**Next Challenge:** [Challenge 2: Process Detective](../challenge2-process-detective/)
