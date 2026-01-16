# CTF Collection Filesystem Integration

## Overview
This document describes the changes made to integrate the `ctf-collection` folder as the base filesystem for the Linux emulator.

## Changes Made

### 1. Initialization of CTF Filesystem
- **Function**: `initializeCTFFilesystem()`
- **Location**: `index.html` (around line 948)
- **Purpose**: Automatically creates the CTF directory structure when the emulator boots
- **Behavior**:
  - Creates a `README.md` file in the root directory with CTF instructions
  - Creates all 8 challenge directories (challenge1-hidden-files through challenge8-intrusion-analysis)
  - Executes automatically after the Linux kernel boots and shell prompt appears

### 2. Modified Emulator Boot Sequence
- **Location**: Serial output listener in `initEmulator()` function
- **Change**: When the emulator detects the shell prompt (boot complete), it now:
  1. Sets status to "Setting up CTF environment..."
  2. Calls `initializeCTFFilesystem()`
  3. Updates status to "Linux is ready" when complete
  4. Shows success message: `[✓ CTF environment ready! Type "ls" to see available challenges]`

### 3. Challenge Loading System Updated
- **Old System**: Downloaded `.tar.gz` files from `disk-images` folder, decompressed using pako library, parsed tar format
- **New System**: Fetches files directly from `ctf-collection/{challenge}/` folder via HTTP
- **Function**: `loadChallengeIntoEmulator(challengeId)` (rewritten)
- **New Behavior**:
  1. Fetches `README.md` from `ctf-collection/{challengeId}/README.md`
  2. Fetches `setup.sh` from `ctf-collection/{challengeId}/setup.sh`
  3. Creates the challenge directory in the emulator
  4. Writes both files to the emulator using base64 encoding
  5. Makes setup.sh executable
  6. Runs the setup script to initialize the challenge environment

### 4. Removed Dependencies
- **Pako Library**: Removed preload link and script tag (no longer needed for tar.gz decompression)
- **parseTar Function**: Removed entirely (no longer needed)
- **sanitizePath Function**: Removed (no longer processing tar archives with potentially unsafe paths)
- **Challenge Metadata**: Removed `filename` field from challenge definitions (no longer using .tar.gz files)

### 5. Helper Functions Retained
- **escapeShell()**: Safely escapes strings for shell commands
- **safeBase64Encode()**: Encodes content to base64, handling UTF-8 characters
- Both functions are still used for secure file creation in the emulator

### 6. Updated UI References
- Info section no longer references `disk-images` folder
- Info section now states challenges are loaded directly from ctf-collection with no downloads

## Expected Behavior

### On Emulator Boot
When the user opens the page and the emulator boots:
1. Linux kernel loads (~10-30 seconds depending on connection)
2. Shell prompt appears
3. CTF filesystem initialization begins automatically
4. A `README.md` file is created in the root with instructions
5. 8 challenge directories are created (empty, ready to receive challenge content)
6. User sees: `[✓ CTF environment ready! Type "ls" to see available challenges]`

### When User Runs `ls`
The user should see:
```
README.md
challenge1-hidden-files
challenge2-process-detective
challenge3-network-navigator
challenge4-log-forensics
challenge5-permission-puzzle
challenge6-archive-archaeology
challenge7-script-debugger
challenge8-intrusion-analysis
```

### When User Loads a Challenge
1. User selects a challenge from the dropdown
2. Clicks "Load Challenge" button
3. System fetches README.md and setup.sh from ctf-collection folder
4. Creates the files in the corresponding challenge directory
5. Runs the setup script to initialize the challenge environment
6. User can navigate to the challenge directory and start solving

## Benefits

1. **Faster Loading**: No need to download and decompress large .tar.gz files
2. **Simpler Architecture**: Direct file fetching instead of tar.gz processing
3. **No Build Step**: Works directly with the repository structure
4. **GitHub Pages Compatible**: No server-side processing required
5. **Easier Maintenance**: Challenge files can be edited directly in the repository

## File Structure

```
TerminalBox/
├── index.html (modified)
├── ctf-collection/
│   ├── challenge1-hidden-files/
│   │   ├── README.md
│   │   └── setup.sh
│   ├── challenge2-process-detective/
│   │   ├── README.md
│   │   └── setup.sh
│   └── ... (6 more challenges)
└── disk-images/ (no longer used, can be removed)
```

## Testing

To test the integration:
1. Start a local web server: `python3 -m http.server 8000`
2. Open http://localhost:8000 in a browser
3. Wait for the emulator to boot
4. Type `ls` in the command input and click "Run"
5. Verify that README.md and all 8 challenge directories are listed
6. Type `cat README.md` to verify the content
7. Select a challenge from the dropdown and click "Load Challenge"
8. Verify that the challenge loads successfully

## Future Improvements

1. Could add a progress indicator for challenge loading
2. Could cache loaded challenges to avoid re-fetching
3. Could add a "Reset Challenge" button to restore original state
4. Could implement lazy loading of challenge descriptions from the repository
