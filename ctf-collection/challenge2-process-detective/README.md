# Challenge 2: Process Detective

**Difficulty:** Easy-Medium  
**Skills:** Process management, ps, grep, kill, background jobs

## Challenge Description

A rogue process is running on the system that contains the flag. Your job is to identify running processes, find the one that contains the flag, and extract it. The process might be hidden among many others, so you'll need to use your process management skills.

## Objective

Find and extract the flag from a running process. The flag format is: `FLAG{...}`

## Setup

Run the setup script to start the challenge:
```bash
bash setup.sh
```

This will start a background process that contains the flag.

## Hints

<details>
<summary>Hint 1 (Click to reveal)</summary>

Use `ps` command to list running processes. Try `ps aux` for detailed information.
</details>

<details>
<summary>Hint 2 (Click to reveal)</summary>

The process command line contains the word "secret". Use `grep` to filter processes.
</details>

<details>
<summary>Hint 3 (Click to reveal)</summary>

Combine `ps` with `grep`: `ps aux | grep secret`
</details>

<details>
<summary>Solution (Click to reveal)</summary>

```bash
# List all processes and search for the flag-bearing process
ps aux | grep secret

# Or use pgrep to find process by name
pgrep -a secret

# The flag will be visible in the command line of the process
```

To clean up, find the process ID and kill it:
```bash
pkill -f secret
# or
kill <PID>
```
</details>

## Cheat Sheet

### Process Management Commands

```bash
# List all processes (BSD style)
ps aux

# List all processes (Unix style)
ps -ef

# List processes for current user
ps -u username

# List processes in a tree structure
ps auxf
pstree

# Display processes with threads
ps -eLf
```

### Filtering and Searching Processes

```bash
# Search for specific process
ps aux | grep process_name

# Find process by name (shows PID and command)
pgrep -a process_name

# Find process ID by name
pgrep process_name

# Find process and show full command
pgrep -af process_name
```

### Viewing Active Processes

```bash
# Display dynamic real-time process information
top

# Interactive process viewer (if installed)
htop

# Display processes sorted by memory usage
ps aux --sort=-%mem | head

# Display processes sorted by CPU usage
ps aux --sort=-%cpu | head
```

### Managing Processes

```bash
# Kill process by PID
kill PID

# Force kill process
kill -9 PID

# Kill process by name
pkill process_name

# Kill all processes matching pattern
pkill -f pattern

# Kill all processes by user
pkill -u username
```

### Background Jobs

```bash
# Run command in background
command &

# List background jobs
jobs

# Bring job to foreground
fg %1

# Send job to background
bg %1

# Run command immune to hangups
nohup command &

# Disown a job (remove from job table)
disown %1
```

### Process Information

```bash
# Show detailed info about a process
ps -p PID -f

# Show environment variables of a process
ps eww -p PID

# Show process tree
ps -ejH
ps axjf

# Get process info from /proc filesystem
cat /proc/PID/cmdline
cat /proc/PID/status
```

### Pipes and Filtering

```bash
# Pipe output to another command
command1 | command2

# Search for pattern in output
command | grep pattern

# Count lines in output
command | wc -l

# Sort output
command | sort

# Show unique lines
command | sort | uniq

# Show top 10 lines
command | head -10

# Show last 10 lines
command | tail -10
```

### Advanced Process Queries

```bash
# Find processes using specific port
lsof -i :port_number

# Find which process is using a file
lsof filename

# List files opened by a process
lsof -p PID

# List all network connections
netstat -tulpn
ss -tulpn
```

### System Monitoring

```bash
# Show system uptime and load average
uptime

# Show memory usage
free -h

# Show disk usage
df -h

# Show running processes summary
ps aux | wc -l

# Watch command output (refresh every 2 seconds)
watch -n 2 'ps aux | grep process'
```

### Useful Tips

- **PID** = Process ID (unique identifier for each process)
- **PPID** = Parent Process ID
- **Top** command: Press 'q' to quit, 'k' to kill a process
- **&** at the end of a command runs it in the background
- **Ctrl+Z** suspends a foreground process
- **Ctrl+C** terminates a foreground process

### Common Process States

- **R** - Running
- **S** - Sleeping (waiting for an event)
- **D** - Uninterruptible sleep
- **Z** - Zombie (terminated but not reaped)
- **T** - Stopped (by job control signal)

## What You Learned

After completing this challenge, you should understand:
- How to list and view running processes
- Using `ps` command with various options
- Filtering process output with `grep`
- Process IDs (PIDs) and process attributes
- How to search for specific processes
- Basic process management and control

---

**Previous Challenge:** [Challenge 1: Hidden Files Explorer](../challenge1-hidden-files/)  
**Next Challenge:** [Challenge 3: Network Navigator](../challenge3-network-navigator/)
