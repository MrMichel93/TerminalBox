# Challenge 8: System Intrusion Analysis

**Difficulty:** Very Hard  
**Skills:** Forensics, system logs, file analysis, security, incident response,综合分析

## Challenge Description

Your system has been compromised! A sophisticated attacker has gained access and left traces throughout the system. Your mission is to perform a comprehensive forensic analysis to piece together what happened, identify the attack vector, and recover the flag that the attacker tried to hide. This challenge combines all the skills you've learned and requires deep system analysis.

## Objective

Analyze the compromised system, trace the attacker's actions, and find the flag. The flag format is: `FLAG{...}`

## Setup

Run the setup script:
```bash
bash setup.sh
```

This will create a simulated compromised system environment with various artifacts.

## Hints

<details>
<summary>Hint 1 (Click to reveal)</summary>

Start by examining the system logs in the `incident/` directory. Look for suspicious activity.
</details>

<details>
<summary>Hint 2 (Click to reveal)</summary>

Check for unusual files, processes, and network connections. The attacker may have left backdoors or hidden files.
</details>

<details>
<summary>Hint 3 (Click to reveal)</summary>

Look for recently modified files, unusual permissions, and encoded data. The flag might be obfuscated.
</details>

<details>
<summary>Hint 4 (Click to reveal)</summary>

Timeline analysis: Look at the auth.log, bash_history, and suspicious_files. Connect the dots.
</details>

<details>
<summary>Solution (Click to reveal)</summary>

1. Examine auth.log for failed and successful logins
2. Check bash_history for attacker commands
3. Find the hidden directory with .attacker_data
4. Decode the base64-encoded flag in the hidden file
5. Analyze file permissions and timestamps

```bash
cd incident
cat logs/auth.log | grep -i "failed\|accepted"
cat .bash_history
find . -name ".*"
cat suspicious_files/.attacker_data/.hidden_flag.txt | base64 -d
```
</details>

## Cheat Sheet

### System Log Analysis

```bash
# Common log locations
/var/log/syslog           # General system log
/var/log/auth.log         # Authentication attempts
/var/log/secure           # Security/auth (RHEL/CentOS)
/var/log/messages         # General messages
/var/log/kern.log         # Kernel logs
/var/log/apache2/         # Web server logs
/var/log/nginx/           # Nginx logs

# View recent log entries
tail -f /var/log/syslog   # Follow in real-time
tail -100 /var/log/auth.log

# Search logs
grep -i "error" /var/log/syslog
grep -i "failed" /var/log/auth.log
grep -i "accepted" /var/log/auth.log

# View logs with journalctl (systemd)
journalctl -xe            # Recent logs with details
journalctl -u service     # Specific service
journalctl --since today
journalctl --since "2024-01-01"
journalctl -f             # Follow
```

### Finding Suspicious Files

```bash
# Find recently modified files (last 7 days)
find / -type f -mtime -7 2>/dev/null

# Find files modified in last 24 hours
find / -type f -mtime 0 2>/dev/null

# Find files by specific date
find / -type f -newermt "2024-01-01" 2>/dev/null

# Find large files
find / -type f -size +100M 2>/dev/null

# Find SUID/SGID files
find / -perm -4000 2>/dev/null  # SUID
find / -perm -2000 2>/dev/null  # SGID

# Find world-writable files
find / -type f -perm -002 2>/dev/null

# Find files owned by specific user
find / -user username 2>/dev/null

# Find files without valid owner
find / -nouser -o -nogroup 2>/dev/null

# Find hidden files
find / -name ".*" -type f 2>/dev/null
```

### Process Analysis

```bash
# List all processes
ps aux
ps -ef

# Find suspicious processes
ps aux | grep -v root     # Non-root processes
ps aux --sort=-%mem       # By memory
ps aux --sort=-%cpu       # By CPU

# Process tree
pstree
ps auxf

# Check process details
ls -l /proc/PID/exe       # Executable path
cat /proc/PID/cmdline     # Command line
cat /proc/PID/environ     # Environment
lsof -p PID               # Open files

# Network connections
netstat -tulpn            # Listening ports
ss -tulpn
lsof -i                   # All network connections
lsof -i :port             # Specific port
```

### Network Analysis

```bash
# Active connections
netstat -antup
ss -antup

# Listening services
netstat -tulpn
ss -tulpn

# Check specific port
lsof -i :22
netstat -an | grep :22

# ARP table
arp -a
ip neigh show

# Routing table
route -n
ip route show

# Check for suspicious connections
netstat -antup | grep ESTABLISHED
```

### User Analysis

```bash
# Current logged-in users
who
w
users

# Login history
last                      # Recent logins
last -f /var/log/wtmp
lastb                     # Failed logins
last -f /var/log/btmp

# Last login per user
lastlog

# Check sudo usage
grep sudo /var/log/auth.log

# Check user accounts
cat /etc/passwd
cat /etc/shadow           # Requires root
getent passwd

# Check for suspicious users
awk -F: '$3 >= 1000 {print $1}' /etc/passwd
```

### File Integrity

```bash
# Check file hashes
md5sum file
sha256sum file

# Compare hashes
md5sum file1 file2
diff <(md5sum file1) <(md5sum file2)

# Verify file hasn't changed
md5sum file > checksum.md5
md5sum -c checksum.md5

# Check package integrity (Debian/Ubuntu)
debsums -c

# Check package integrity (RHEL/CentOS)
rpm -Va
```

### Analyzing Encoded/Hidden Data

```bash
# Base64 decode
echo "encoded_string" | base64 -d
base64 -d file.b64

# Hex decode
xxd -r -p hexfile
echo "hex_string" | xxd -r -p

# URL decode
python3 -c "import urllib.parse; print(urllib.parse.unquote('url_encoded'))"

# ROT13 decode
echo "encoded" | tr 'A-Za-z' 'N-ZA-Mn-za-m'

# Check file for strings
strings filename
strings -n 10 filename    # Min length 10

# Find printable strings in binary
strings /bin/ls

# Extract embedded files
binwalk -e file
foremost file
```

### Timeline Analysis

```bash
# File access times
stat filename
ls -lu                    # Last access
ls -l                     # Last modification
ls -lc                    # Last status change

# Find files in time range
find / -type f -newermt "2024-01-01 00:00" -not -newermt "2024-01-01 23:59" 2>/dev/null

# Sort files by time
ls -ltr                   # Modification time
ls -ltur                  # Access time

# File timeline
find / -type f -printf "%T@ %Tc %p\n" 2>/dev/null | sort -n
```

### Command History

```bash
# Bash history
cat ~/.bash_history
history

# Root history
sudo cat /root/.bash_history

# All users' history
find /home -name ".bash_history" -exec cat {} \;

# Check history timestamp
export HISTTIMEFORMAT="%F %T "
history

# Search history
history | grep command
grep command ~/.bash_history
```

### Checking Backdoors

```bash
# Check cron jobs
crontab -l                # Current user
sudo crontab -l           # Root
ls -la /etc/cron.*
cat /etc/crontab

# Check startup scripts
ls -la /etc/rc*.d/
systemctl list-unit-files

# Check for rootkits
chkrootkit               # If installed
rkhunter --check         # If installed

# Check loaded kernel modules
lsmod
cat /proc/modules

# Check for unusual services
systemctl list-units --type=service
service --status-all
```

### Memory Analysis

```bash
# Check system memory
free -h
cat /proc/meminfo

# Check swap
swapon --show
cat /proc/swaps

# Core dumps
ls -la /var/crash/
ls -la /var/core/
```

### Incident Response Steps

```
1. Identification
   - Detect anomalies
   - Verify incident

2. Containment
   - Isolate affected systems
   - Prevent spread

3. Eradication
   - Remove threat
   - Patch vulnerabilities

4. Recovery
   - Restore systems
   - Verify functionality

5. Lessons Learned
   - Document findings
   - Improve defenses
```

### Forensics Best Practices

```bash
# Create working copy
cp -a original_dir/ analysis_dir/

# Document everything
script -a investigation.log

# Hash evidence before analysis
md5sum evidence > evidence.md5

# Preserve timestamps
cp -p file destination

# Use read-only mounts
mount -o ro,noexec /dev/sdb1 /mnt

# Chain of custody
- Document who, what, when, where, why
- Keep detailed logs
- Maintain evidence integrity
```

### Common Attack Indicators

```
- Multiple failed login attempts
- Successful login from unusual IP/time
- New user accounts
- Modified system files
- Unusual outbound connections
- High CPU/network usage
- Modified logs
- Suspicious cron jobs
- Unknown processes
- Backdoor files
- Unusual SUID files
```

### Useful Tools

```bash
# File analysis
file                     # Identify file type
strings                  # Extract strings
hexdump                  # View hex
xxd                      # Hex dump

# Network
tcpdump                  # Packet capture
wireshark/tshark         # Network analysis
netstat/ss               # Connections

# System
strace                   # System calls
ltrace                   # Library calls
lsof                     # Open files

# Searching
grep/egrep               # Text search
find                     # File search
locate                   # Fast file find
```

## What You Learned

After completing this challenge, you should understand:
- Comprehensive system forensics methodology
- Analyzing system logs for security incidents
- Identifying suspicious files and processes
- Timeline analysis and attack reconstruction
- Data encoding and obfuscation techniques
- Network connection analysis
- User activity investigation
- Combining multiple CLI skills for complex analysis
- Incident response procedures
- Security best practices

---

**Previous Challenge:** [Challenge 7: Script Debugger](../challenge7-script-debugger/)  
**Congratulations!** You've completed all challenges!
