#!/bin/bash

# Challenge 6: Archive Archaeology - Setup Script

echo "Setting up Challenge 6: Archive Archaeology..."

# Create temporary directory for building nested archives
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Create the innermost file with the flag
echo "FLAG{4rch1v3_4rch4301og1st_m4st3r}" > flag.txt

# Layer 5: Create tar archive
tar -cf layer5.tar flag.txt
rm flag.txt

# Layer 4: Compress with gzip
gzip layer5.tar
mv layer5.tar.gz layer4.gz

# Layer 3: Create tar.bz2 archive
tar -cjf layer3.tar.bz2 layer4.gz
rm layer4.gz

# Layer 2: Create zip archive
zip -q layer2.zip layer3.tar.bz2
rm layer3.tar.bz2

# Layer 1: Create tar.gz archive
tar -czf layer1.tar.gz layer2.zip
rm layer2.zip

# Move to original location
mv layer1.tar.gz "$OLDPWD/"
cd "$OLDPWD"
rm -rf "$TEMP_DIR"

echo "Setup complete!"
echo ""
echo "A nested archive 'layer1.tar.gz' has been created."
echo ""
echo "Your mission: Extract all the layers to find the flag."
echo ""
echo "Tips:"
echo "  - Use 'file' command to identify archive types"
echo "  - Extract one layer at a time"
echo "  - Keep track of what you've extracted"
echo ""
echo "Archive structure:"
echo "  layer1.tar.gz"
echo "    └─ layer2.zip"
echo "        └─ layer3.tar.bz2"
echo "            └─ layer4.gz"
echo "                └─ layer5.tar"
echo "                    └─ flag.txt"
echo ""
echo "Start with: tar -xzf layer1.tar.gz"
