#!/bin/bash

# Challenge 8: System Intrusion Analysis - Setup Script

echo "Setting up Challenge 8: System Intrusion Analysis..."

# Create incident directory structure
mkdir -p incident/logs
mkdir -p incident/suspicious_files/.attacker_data
mkdir -p incident/user_data

# Create auth log with suspicious activities
cat > incident/logs/auth.log << 'EOF'
Dec 15 08:23:45 server sshd[1234]: Failed password for root from 192.168.1.100 port 45678 ssh2
Dec 15 08:23:50 server sshd[1235]: Failed password for root from 192.168.1.100 port 45679 ssh2
Dec 15 08:23:55 server sshd[1236]: Failed password for root from 192.168.1.100 port 45680 ssh2
Dec 15 08:24:12 server sshd[1237]: Failed password for admin from 192.168.1.100 port 45681 ssh2
Dec 15 08:24:18 server sshd[1238]: Failed password for admin from 192.168.1.100 port 45682 ssh2
Dec 15 08:24:45 server sshd[1239]: Accepted password for backup from 192.168.1.100 port 45683 ssh2
Dec 15 08:25:01 server sudo: backup : TTY=pts/0 ; PWD=/home/backup ; USER=root ; COMMAND=/bin/bash
Dec 15 08:25:01 server sudo: pam_unix(sudo:session): session opened for user root by backup(uid=0)
Dec 15 08:26:30 server sshd[1239]: Received disconnect from 192.168.1.100 port 45683:11: disconnected by user
Dec 15 08:26:30 server sshd[1239]: Disconnected from user backup 192.168.1.100 port 45683
Dec 15 09:15:22 server sshd[1456]: Accepted publickey for backup from 192.168.1.100 port 46789 ssh2
Dec 15 09:15:45 server sudo: backup : TTY=pts/1 ; PWD=/home/backup ; USER=root ; COMMAND=/usr/bin/find / -name "*.conf"
Dec 15 09:16:12 server sshd[1456]: Received disconnect from 192.168.1.100 port 46789:11: disconnected by user
EOF

# Create bash history showing attacker commands
cat > incident/.bash_history << 'EOF'
whoami
id
uname -a
cat /etc/passwd
cat /etc/shadow
ls -la /root
find / -name "*.conf" 2>/dev/null
ps aux
netstat -tulpn
history
cat /var/log/auth.log | grep -i failed
mkdir .attacker_data
cd .attacker_data
echo "RkxBR3tzeXN0M21fYnIzNGNoX2QzdDNjdDNkX2Y0MTFz}" > .hidden_flag.txt
chmod 600 .hidden_flag.txt
cd ..
history -c
EOF

# Create the hidden flag (base64 encoded)
echo "RkxBR3tzeXN0M21fYnIzNGNoX2QzdDNjdDNkX2Y0MTFz}" > incident/suspicious_files/.attacker_data/.hidden_flag.txt
chmod 600 incident/suspicious_files/.attacker_data/.hidden_flag.txt

# Create some decoy suspicious files
cat > incident/suspicious_files/suspicious_script.sh << 'EOF'
#!/bin/bash
# This looks suspicious but is a decoy
nc -l 4444 &
EOF
chmod 755 incident/suspicious_files/suspicious_script.sh

cat > incident/suspicious_files/README.txt << 'EOF'
This directory contains files recovered from the compromised system.
Look carefully through all files, including hidden ones.
The attacker was sophisticated and tried to cover their tracks.
EOF

# Create a timeline file
cat > incident/timeline.txt << 'EOF'
INCIDENT TIMELINE ANALYSIS
===========================

08:23:45 - Multiple failed SSH login attempts for root account from 192.168.1.100
08:24:12 - Failed login attempts switch to 'admin' account
08:24:45 - SUCCESSFUL login as 'backup' user from 192.168.1.100
08:25:01 - User 'backup' escalates to root using sudo
08:26:30 - Session disconnected
09:15:22 - Attacker returns using SSH key authentication
09:15:45 - Root commands executed to search for config files
09:16:12 - Session disconnected

QUESTIONS TO INVESTIGATE:
1. How did the attacker gain initial access?
2. What commands did they run?
3. What did they leave behind?
4. Where is the flag hidden?

HINT: Check the .bash_history file and look for hidden directories and encoded data.
EOF

# Create investigation notes
cat > incident/investigation_notes.txt << 'EOF'
INVESTIGATION NOTES
===================

INITIAL FINDINGS:
- Multiple failed brute force attempts on root and admin accounts
- Successful compromise of 'backup' account
- Privilege escalation to root via sudo
- Second access using SSH key (persistence mechanism)

EVIDENCE LOCATIONS:
1. logs/auth.log - Authentication logs showing the attack
2. .bash_history - Commands executed by attacker
3. suspicious_files/ - Files left by attacker (check hidden files!)

ANALYSIS TASKS:
1. Review auth.log for attack timeline
2. Examine bash history for attacker actions
3. Search for hidden files and directories
4. Look for encoded or obfuscated data
5. Check file permissions and timestamps

The flag is hidden somewhere in the evidence. 
Use your forensics skills to find it!
EOF

# Set realistic timestamps (making some files appear recently modified)
touch -t 202412150825 incident/logs/auth.log
touch -t 202412150826 incident/.bash_history
touch -t 202412150915 incident/suspicious_files/.attacker_data/.hidden_flag.txt

echo "Setup complete!"
echo ""
echo "==================================="
echo "INCIDENT RESPONSE SCENARIO"
echo "==================================="
echo ""
echo "Your organization's server has been compromised!"
echo "Evidence has been collected in the 'incident/' directory."
echo ""
echo "Your mission: Perform a forensic analysis to:"
echo "  1. Understand how the attacker gained access"
echo "  2. Identify what actions they took"
echo "  3. Find the flag they tried to hide"
echo ""
echo "START YOUR INVESTIGATION:"
echo "  cd incident"
echo "  cat investigation_notes.txt"
echo ""
echo "KEY FILES TO EXAMINE:"
echo "  - logs/auth.log (authentication logs)"
echo "  - .bash_history (command history)"
echo "  - timeline.txt (timeline analysis)"
echo "  - suspicious_files/ (recovered files)"
echo ""
echo "FORENSICS TIPS:"
echo "  - Look for patterns in logs"
echo "  - Check for hidden files (ls -la)"
echo "  - Examine encoded data (base64, hex)"
echo "  - Analyze timestamps and permissions"
echo "  - Connect the evidence pieces"
echo ""
echo "This is the final challenge. Good luck, detective!"
echo "==================================="
