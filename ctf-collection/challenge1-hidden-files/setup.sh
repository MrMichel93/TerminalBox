#!/bin/bash

# Challenge 1: Hidden Files Explorer - Setup Script

echo "Setting up Challenge 1: Hidden Files Explorer..."

# Create main directory
mkdir -p mystery_dir

# Create some regular visible files as decoys
echo "This is not the flag." > mystery_dir/readme.txt
echo "Keep searching!" > mystery_dir/note.txt
mkdir -p mystery_dir/documents
echo "Nothing here either." > mystery_dir/documents/report.txt

# Create hidden directory
mkdir -p mystery_dir/.secrets

# Create the flag in a hidden file
echo "FLAG{h1dd3n_f1l3s_4r3_3v3rywh3r3}" > mystery_dir/.secrets/.hidden_treasure

# Create some additional hidden files as decoys
echo "Almost there..." > mystery_dir/.secrets/.clue
echo "You're getting warmer!" > mystery_dir/.cache

# Create another hidden directory with a decoy
mkdir -p mystery_dir/.config
echo "This is just a config file." > mystery_dir/.config/settings

echo "Setup complete! Navigate to the 'mystery_dir' directory and start searching for the flag."
echo "Hint: The flag format is FLAG{...}"
