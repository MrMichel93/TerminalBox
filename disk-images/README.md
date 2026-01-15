# CTF Challenge Disk Images

This directory contains disk images for all CTF challenges in the repository. These disk images are designed to be easily distributed, hosted, and loaded on different websites or platforms.

## 🌐 GitHub Pages Hosting

These disk images are hosted via GitHub Pages and can be accessed at:
- **Browse all challenges:** `https://yourusername.github.io/TerminalBox/disk-images/`
- **Direct downloads:** `https://yourusername.github.io/TerminalBox/disk-images/challenge1-hidden-files.tar.gz`

Replace `yourusername` with the actual GitHub username once GitHub Pages is enabled for this repository.

## About the Disk Images

Each disk image is a compressed tar.gz archive containing a complete CTF challenge environment, including:
- Challenge setup script (`setup.sh`)
- Challenge documentation (`README.md`)
- All necessary files and configurations

## Available Disk Images

1. **challenge1-hidden-files.tar.gz** - Hidden Files Explorer (Easy)
2. **challenge2-process-detective.tar.gz** - Process Detective (Easy)
3. **challenge3-network-navigator.tar.gz** - Network Navigator (Medium)
4. **challenge4-log-forensics.tar.gz** - Log File Forensics (Medium)
5. **challenge5-permission-puzzle.tar.gz** - Permission Puzzle (Medium)
6. **challenge6-archive-archaeology.tar.gz** - Archive Archaeology (Hard)
7. **challenge7-script-debugger.tar.gz** - Script Debugger (Hard)
8. **challenge8-intrusion-analysis.tar.gz** - System Intrusion Analysis (Very Hard)

## How to Use

### Download and Extract a Challenge

```bash
# Download the disk image (or copy it to your system)
# Extract the challenge
tar -xzf challenge1-hidden-files.tar.gz

# Navigate to the challenge directory
cd challenge1-hidden-files

# Read the challenge instructions
cat README.md

# Run the setup script to initialize the challenge
bash setup.sh
```

### For Website Hosting

These disk images can be:
- Uploaded to a web server for direct download
- Hosted on platforms like GitHub Releases, S3, or CDNs
- Embedded in educational platforms or CTF hosting services
- Distributed to students or participants in training sessions

**Hosting Requirements:**
- Total size of all 8 disk images: ~28KB (extremely lightweight)
- Individual file sizes range from 2KB to 6KB
- Minimal bandwidth requirements - suitable for any hosting environment
- No special server configuration needed

### Example: Serving via HTTP

```bash
# Simple HTTP server for testing
python3 -m http.server 8000

# Users can then download with:
# wget http://your-server:8000/challenge1-hidden-files.tar.gz
```

## Disk Image Format

- **Format**: tar.gz (gzipped tar archive)
- **Compression**: gzip
- **Compatible with**: All major operating systems (Linux, macOS, Windows with appropriate tools)

## Regenerating Disk Images

If you need to regenerate these disk images after making changes to the challenges:

```bash
# Navigate to your CTF-Challenges repository directory
cd ~/CTF-Challenges

# Create disk images for all challenges
tar -czf "Disk Images/challenge1-hidden-files.tar.gz" challenge1-hidden-files/
tar -czf "Disk Images/challenge2-process-detective.tar.gz" challenge2-process-detective/
tar -czf "Disk Images/challenge3-network-navigator.tar.gz" challenge3-network-navigator/
tar -czf "Disk Images/challenge4-log-forensics.tar.gz" challenge4-log-forensics/
tar -czf "Disk Images/challenge5-permission-puzzle.tar.gz" challenge5-permission-puzzle/
tar -czf "Disk Images/challenge6-archive-archaeology.tar.gz" challenge6-archive-archaeology/
tar -czf "Disk Images/challenge7-script-debugger.tar.gz" challenge7-script-debugger/
tar -czf "Disk Images/challenge8-intrusion-analysis.tar.gz" challenge8-intrusion-analysis/
```

## Verification

To verify the integrity of a disk image:

```bash
# List contents without extracting
tar -tzf challenge1-hidden-files.tar.gz

# Extract to a test directory
mkdir test-extract
tar -xzf challenge1-hidden-files.tar.gz -C test-extract
```

## Notes

- Each disk image is self-contained and includes everything needed to run the challenge
- The setup scripts create the challenge environment dynamically
- Some challenges may require specific tools (bash, Python 3, etc.) which should be available on most Linux systems
- Disk images are kept small and portable for easy distribution

## Support

For issues or questions about the challenges, please refer to the main repository README or open an issue on GitHub.
