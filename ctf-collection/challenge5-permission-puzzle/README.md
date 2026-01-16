# Challenge 5: Permission Puzzle

**Difficulty:** Medium-Hard  
**Skills:** File permissions, chmod, chown, user/group management, SUID/SGID

## Challenge Description

You've discovered a secure vault directory with various files, but they all have different permission restrictions. Your task is to understand and manipulate file permissions to access the flag. This challenge tests your knowledge of Linux file permissions, ownership, and special permission bits.

## Objective

Navigate the permission restrictions and read the flag. The flag format is: `FLAG{...}`

## Setup

Run the setup script:
```bash
bash setup.sh
```

This will create a directory structure with various permission challenges.

## Hints

<details>
<summary>Hint 1 (Click to reveal)</summary>

Use `ls -l` to see file permissions. The format is: `-rwxrwxrwx` (owner, group, others).
</details>

<details>
<summary>Hint 2 (Click to reveal)</summary>

Use `chmod` to change permissions. For example: `chmod +r filename` to add read permission.
</details>

<details>
<summary>Hint 3 (Click to reveal)</summary>

Check the `instructions.txt` file in the vault directory. You might need to make it readable first.
</details>

<details>
<summary>Solution (Click to reveal)</summary>

```bash
cd vault

# Make instructions readable
chmod +r instructions.txt
cat instructions.txt

# Make locked_dir accessible
chmod +x locked_dir
cd locked_dir

# Make secret.txt readable
chmod +r secret.txt
cat secret.txt
```

The flag is in `vault/locked_dir/secret.txt` after fixing permissions.
</details>

## Cheat Sheet

### Understanding Permissions

```
Permission format: -rwxrwxrwx
                   - --- --- ---
                   | |   |   |
                   | |   |   +-- Others (everyone else)
                   | |   +------ Group
                   | +---------- Owner (user)
                   +------------ File type (- = file, d = directory, l = link)

r = read (4)
w = write (2)
x = execute (1)
```

### Viewing Permissions

```bash
# List files with permissions
ls -l

# List all files including hidden
ls -la

# List directory permissions
ls -ld directory_name

# Show numeric permissions
stat -c '%a %n' filename

# Detailed file information
stat filename
```

### Changing Permissions with chmod

```bash
# Symbolic mode (add/remove/set)
chmod +r filename      # Add read for all
chmod -w filename      # Remove write for all
chmod +x filename      # Add execute for all

# Specific user classes
chmod u+x filename     # Add execute for owner (user)
chmod g+w filename     # Add write for group
chmod o-r filename     # Remove read for others
chmod a+r filename     # Add read for all (user, group, others)

# Set exact permissions
chmod u=rwx filename   # Owner: read, write, execute
chmod g=rx filename    # Group: read, execute
chmod o= filename      # Others: no permissions

# Multiple changes
chmod u+x,g+x,o-w filename

# Numeric mode (octal)
chmod 755 filename     # rwxr-xr-x
chmod 644 filename     # rw-r--r--
chmod 600 filename     # rw-------
chmod 777 filename     # rwxrwxrwx
chmod 000 filename     # ---------

# Recursive (apply to directory and contents)
chmod -R 755 directory/

# Copy permissions from another file
chmod --reference=file1 file2
```

### Common Permission Values

```
0 (---) = No permission
1 (--x) = Execute only
2 (-w-) = Write only
3 (-wx) = Write and execute
4 (r--) = Read only
5 (r-x) = Read and execute
6 (rw-) = Read and write
7 (rwx) = Read, write, and execute

Common combinations:
644 = rw-r--r-- (files - owner read/write, others read)
755 = rwxr-xr-x (executables/directories - owner full, others read/execute)
600 = rw------- (private files)
700 = rwx------ (private executables/directories)
666 = rw-rw-rw- (everyone can read/write)
777 = rwxrwxrwx (everyone full access - dangerous!)
```

### Changing Ownership

```bash
# Change owner
chown username filename

# Change owner and group
chown username:groupname filename

# Change only group
chown :groupname filename
chgrp groupname filename

# Recursive
chown -R username:groupname directory/

# Change to current user
chown $USER filename
```

### Special Permissions

```bash
# SUID (Set User ID) - run as owner
chmod u+s filename      # Symbolic
chmod 4755 filename     # Numeric
# Shows as: -rwsr-xr-x

# SGID (Set Group ID) - run as group / inherit group
chmod g+s filename      # Symbolic
chmod 2755 filename     # Numeric
# Shows as: -rwxr-sr-x

# Sticky bit - only owner can delete
chmod +t directory      # Symbolic
chmod 1755 directory    # Numeric
# Shows as: drwxr-xr-t

# Combining special permissions
chmod 6755 filename     # SUID + SGID
chmod 7755 filename     # SUID + SGID + Sticky
```

### Default Permissions (umask)

```bash
# View current umask
umask

# Set umask (subtract from 666 for files, 777 for dirs)
umask 022              # Creates files as 644, dirs as 755
umask 077              # Creates files as 600, dirs as 700

# View in symbolic form
umask -S
```

### Access Control Lists (ACLs)

```bash
# View ACLs
getfacl filename

# Set ACL
setfacl -m u:username:rwx filename

# Remove ACL
setfacl -x u:username filename

# Remove all ACLs
setfacl -b filename

# Copy ACLs
getfacl file1 | setfacl --set-file=- file2
```

### Testing Permissions

```bash
# Test if file is readable
test -r filename && echo "Readable"

# Test if file is writable
test -w filename && echo "Writable"

# Test if file is executable
test -x filename && echo "Executable"

# Try to read file
cat filename 2>/dev/null || echo "Cannot read"

# Check if you can access directory
cd directory 2>/dev/null && echo "Can access"
```

### Finding Files by Permission

```bash
# Find files with specific permissions
find . -perm 644

# Find files with at least these permissions
find . -perm -644

# Find files with any of these permissions
find . -perm /644

# Find SUID files
find / -perm -4000 2>/dev/null

# Find SGID files
find / -perm -2000 2>/dev/null

# Find writable files
find . -writable

# Find executable files
find . -executable
```

### User and Group Information

```bash
# Show current user
whoami
id

# Show user details
id username

# List groups for user
groups username

# Show all users
cat /etc/passwd

# Show all groups
cat /etc/group

# Add user to group
sudo usermod -aG groupname username
```

### Troubleshooting Permissions

```bash
# Check effective permissions
namei -l /path/to/file

# Check what you can do
ls -l filename
stat filename

# Check directory permissions in path
ls -ld /path
ls -ld /path/to
ls -ld /path/to/file

# See denied operations
dmesg | grep -i denied
```

### Best Practices

1. **Least Privilege**: Give minimum necessary permissions
2. **Regular Files**: Usually 644 (rw-r--r--)
3. **Executables**: Usually 755 (rwxr-xr-x)
4. **Private Files**: Use 600 (rw-------)
5. **Directories**: Need execute (+x) to access contents
6. **Never 777**: Avoid unless absolutely necessary
7. **SUID/SGID**: Use carefully - security implications

### Common Errors

```
Permission denied - Need read/execute permission
Cannot execute - Need execute permission (+x)
Cannot cd - Directory needs execute permission
Cannot ls - Directory needs read permission
Cannot create/delete - Need write permission on directory
```

## What You Learned

After completing this challenge, you should understand:
- Linux file permission structure (rwx)
- How to read permission strings (ls -l)
- Using chmod to modify permissions
- Numeric (octal) vs symbolic permission notation
- Ownership and how to change it
- Special permissions (SUID, SGID, sticky bit)
- Directory permissions and their implications
- Security best practices for permissions

---

**Previous Challenge:** [Challenge 4: Log File Forensics](../challenge4-log-forensics/)  
**Next Challenge:** [Challenge 6: Archive Archaeology](../challenge6-archive-archaeology/)
