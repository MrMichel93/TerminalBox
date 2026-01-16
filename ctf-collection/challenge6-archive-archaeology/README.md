# Challenge 6: Archive Archaeology

**Difficulty:** Hard  
**Skills:** Archive extraction, tar, gzip, bzip2, zip, nested archives, file types

## Challenge Description

You've been given a mysterious archive file. Inside, there are multiple layers of compressed archives, each containing another archive. Your mission is to extract all the layers and find the flag buried deep within. This challenge tests your knowledge of various archive formats and compression tools.

## Objective

Extract all nested archives and find the flag. The flag format is: `FLAG{...}`

## Setup

Run the setup script:
```bash
bash setup.sh
```

This will create a deeply nested archive structure.

## Hints

<details>
<summary>Hint 1 (Click to reveal)</summary>

Use the `file` command to identify what type of archive or compression you're dealing with.
</details>

<details>
<summary>Hint 2 (Click to reveal)</summary>

Different archive formats require different tools: tar, gunzip, bunzip2, unzip, etc.
</details>

<details>
<summary>Hint 3 (Click to reveal)</summary>

Extract one layer at a time, checking what you've extracted before proceeding to the next layer.
</details>

<details>
<summary>Solution (Click to reveal)</summary>

```bash
# Layer 1: tar.gz
tar -xzf layer1.tar.gz

# Layer 2: zip
unzip layer2.zip

# Layer 3: tar.bz2
tar -xjf layer3.tar.bz2

# Layer 4: gzip
gunzip layer4.gz

# Layer 5: tar
tar -xf layer5.tar

# Read the flag
cat flag.txt
```
</details>

## Cheat Sheet

### Identifying File Types

```bash
# Determine file type
file filename

# Check file with multiple files
file *

# Follow symlinks
file -L filename

# Show MIME type
file -i filename

# Brief mode
file -b filename
```

### TAR Archives

```bash
# Create tar archive
tar -cf archive.tar files/

# Create tar with verbose output
tar -cvf archive.tar files/

# Extract tar archive
tar -xf archive.tar

# Extract with verbose output
tar -xvf archive.tar

# Extract to specific directory
tar -xf archive.tar -C /path/to/dir

# List contents without extracting
tar -tf archive.tar

# Extract specific file
tar -xf archive.tar path/to/file

# Create tar and compress with gzip (.tar.gz or .tgz)
tar -czf archive.tar.gz files/

# Extract tar.gz
tar -xzf archive.tar.gz

# Create tar and compress with bzip2 (.tar.bz2)
tar -cjf archive.tar.bz2 files/

# Extract tar.bz2
tar -xjf archive.tar.bz2

# Create tar and compress with xz (.tar.xz)
tar -cJf archive.tar.xz files/

# Extract tar.xz
tar -xJf archive.tar.xz
```

### GZIP Compression

```bash
# Compress file
gzip filename
# Creates filename.gz, removes original

# Compress and keep original
gzip -k filename

# Decompress
gunzip filename.gz
gzip -d filename.gz

# Decompress and keep compressed file
gunzip -k filename.gz

# Compress with best compression
gzip -9 filename

# Compress with fast compression
gzip -1 filename

# View compressed file content
zcat filename.gz
zless filename.gz
zmore filename.gz

# Search in compressed files
zgrep pattern filename.gz
```

### BZIP2 Compression

```bash
# Compress file
bzip2 filename
# Creates filename.bz2, removes original

# Compress and keep original
bzip2 -k filename

# Decompress
bunzip2 filename.bz2
bzip2 -d filename.bz2

# Decompress and keep compressed file
bunzip2 -k filename.bz2

# View compressed file content
bzcat filename.bz2
bzless filename.bz2

# Search in compressed files
bzgrep pattern filename.bz2
```

### ZIP Archives

```bash
# Create zip archive
zip archive.zip file1 file2

# Create zip recursively
zip -r archive.zip directory/

# Extract zip archive
unzip archive.zip

# Extract to specific directory
unzip archive.zip -d /path/to/dir

# List contents without extracting
unzip -l archive.zip

# Test zip integrity
unzip -t archive.zip

# Extract specific file
unzip archive.zip path/to/file

# Extract quietly
unzip -q archive.zip

# Overwrite without prompting
unzip -o archive.zip

# Create encrypted zip
zip -e -r archive.zip directory/

# Set compression level (0-9)
zip -9 -r archive.zip directory/
```

### XZ Compression

```bash
# Compress file
xz filename
# Creates filename.xz, removes original

# Compress and keep original
xz -k filename

# Decompress
unxz filename.xz
xz -d filename.xz

# View compressed file content
xzcat filename.xz

# Compress with best compression
xz -9 filename
```

### RAR Archives (if installed)

```bash
# Extract rar archive
unrar x archive.rar

# List contents
unrar l archive.rar

# Test archive
unrar t archive.rar

# Extract to specific directory
unrar x archive.rar /path/to/dir
```

### 7-Zip (if installed)

```bash
# Extract archive
7z x archive.7z

# Create archive
7z a archive.7z files/

# List contents
7z l archive.7z

# Test archive
7z t archive.7z

# Extract with full paths
7z x archive.7z

# Extract without paths
7z e archive.7z
```

### Advanced TAR Options

```bash
# Create archive and show progress
tar -czf archive.tar.gz files/ --checkpoint=.1000

# Exclude files
tar -czf archive.tar.gz --exclude='*.log' files/

# Preserve permissions
tar -czpf archive.tar.gz files/

# Create incremental backup
tar -czf backup.tar.gz --listed-incremental=snapshot.file files/

# Extract and preserve permissions
tar -xzpf archive.tar.gz

# Create archive with specific owner
tar -czf archive.tar.gz --owner=root files/

# Strip leading directory components
tar -xzf archive.tar.gz --strip-components=1
```

### Combining Commands

```bash
# Create tar.gz in one command
tar -czf archive.tar.gz directory/

# Extract tar.gz in one command
tar -xzf archive.tar.gz

# Create tar.bz2 in one command
tar -cjf archive.tar.bz2 directory/

# Extract tar.bz2 in one command
tar -xjf archive.tar.bz2

# Pipe archives
tar -czf - directory/ | ssh remote 'tar -xzf -'

# Archive and split
tar -czf - largedir/ | split -b 100M - archive.tar.gz.

# Combine and extract split archive
cat archive.tar.gz.* | tar -xzf -
```

### Useful Patterns

```bash
# Extract and examine in one go
tar -xzf archive.tar.gz && ls -la

# Chain extractions
tar -xzf layer1.tar.gz && unzip layer2.zip && tar -xjf layer3.tar.bz2

# Loop through archives
for file in *.tar.gz; do tar -xzf "$file"; done

# Extract all zip files in directory
unzip '*.zip'

# Find and extract all gzip files
find . -name "*.gz" -exec gunzip {} \;
```

### Archive Information

```bash
# Check tar contents
tar -tvf archive.tar

# Check tar.gz contents
tar -tzvf archive.tar.gz

# Show archive size
du -h archive.tar.gz

# Compare archive contents
diff <(tar -tf archive1.tar | sort) <(tar -tf archive2.tar | sort)
```

### Troubleshooting

```bash
# Verify tar archive
tar -tvf archive.tar > /dev/null && echo "OK" || echo "Corrupted"

# Fix corrupted tar
dd if=corrupted.tar of=fixed.tar conv=noerror,sync

# Extract with error handling
tar -xzf archive.tar.gz 2>&1 | tee extract.log

# Force extraction of problematic archive
tar -xzf archive.tar.gz --ignore-failed-read

# Skip existing files
tar -xzf archive.tar.gz --skip-old-files
```

### Useful Tips

- **Always check** file type with `file` command first
- **`.tar.gz` and `.tgz`** are the same
- **`.tar.bz2` and `.tbz2`** are the same
- **TAR doesn't compress** - it just archives (bundles)
- **Compression** is separate (gzip, bzip2, xz)
- **Modern tar** auto-detects compression with `-a` flag
- **Use `-v`** for verbose output to see what's happening
- **Always test** archives after creation

### Common Extensions

- **.tar** - TAR archive (uncompressed)
- **.gz** - GZIP compressed
- **.tar.gz, .tgz** - TAR + GZIP
- **.bz2** - BZIP2 compressed
- **.tar.bz2, .tbz2** - TAR + BZIP2
- **.xz** - XZ compressed
- **.tar.xz** - TAR + XZ
- **.zip** - ZIP archive
- **.rar** - RAR archive
- **.7z** - 7-Zip archive

## What You Learned

After completing this challenge, you should understand:
- Different archive and compression formats
- How to identify file types
- Using tar for archiving with various compression methods
- Working with gzip, bzip2, and xz compression
- Extracting and creating zip archives
- Handling nested archives systematically
- Difference between archiving and compression

---

**Previous Challenge:** [Challenge 5: Permission Puzzle](../challenge5-permission-puzzle/)  
**Next Challenge:** [Challenge 7: Script Debugger](../challenge7-script-debugger/)
