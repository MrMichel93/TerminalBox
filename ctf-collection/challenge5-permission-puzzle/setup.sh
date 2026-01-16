#!/bin/bash

# Challenge 5: Permission Puzzle - Setup Script

echo "Setting up Challenge 5: Permission Puzzle..."

# Create the vault directory
mkdir -p vault/locked_dir

# Create instructions file (initially not readable)
cat > vault/instructions.txt << 'EOF'
VAULT SECURITY INSTRUCTIONS
============================

To access the vault contents, you must:
1. Make this file readable (it's currently write-only)
2. Navigate to the locked_dir (fix directory permissions)
3. Read the secret.txt file (fix its permissions)

The flag awaits those who understand Linux permissions!
EOF

chmod 200 vault/instructions.txt  # Write-only

# Create the secret file with the flag (initially not readable)
echo "FLAG{p3rm1ss10n_m4st3r_unl0ck3d}" > vault/locked_dir/secret.txt
chmod 000 vault/locked_dir/secret.txt  # No permissions

# Make the directory inaccessible initially
chmod 000 vault/locked_dir

# Create some decoy files with various permissions
echo "This is a decoy file." > vault/decoy1.txt
chmod 444 vault/decoy1.txt  # Read-only

echo "Another decoy file." > vault/decoy2.txt
chmod 111 vault/decoy2.txt  # Execute-only (weird but possible)

mkdir -p vault/empty_dir
chmod 755 vault/empty_dir

echo "Setup complete!"
echo ""
echo "The vault has been created with various permission challenges."
echo ""
echo "Your mission: Navigate the permission restrictions and find the flag."
echo ""
echo "Start by examining the vault directory:"
echo "  cd vault"
echo "  ls -la"
echo ""
echo "Hint: Not everything is accessible at first. You'll need to fix permissions!"
echo ""
echo "Key commands you'll need:"
echo "  ls -l    (view permissions)"
echo "  chmod    (change permissions)"
echo "  cat      (read files)"
