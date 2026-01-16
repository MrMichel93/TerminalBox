# CTF Collection Filesystem Integration

## Overview
This document describes how the `ctf-collection` folder is integrated as the base filesystem for the Linux emulator. All challenge files are pre-created in the repository and loaded directly into the emulator without executing any shell scripts.

## Current Implementation

### 1. File-Based Loading System
- **Function**: `setupChallengeFiles(challengeId)`
- **Location**: `index.html`
- **Purpose**: Loads pre-existing files from the ctf-collection folder into the emulator
- **Behavior**:
  - Uses a manifest (`challengeFiles` object) that lists all files for each challenge
  - Fetches each file directly from `ctf-collection/{challenge}/{filepath}`
  - Recreates the directory structure in the emulator
  - Sets executable permissions where needed
  - **Does NOT execute any shell scripts**

### 2. Challenge File Manifests
- **Object**: `challengeFiles`
- **Location**: `index.html` (defined after `challenges` object)
- **Purpose**: Lists all files that should be loaded for each challenge
- **Structure**:
  ```javascript
  'challenge-name': [
    { path: 'file/path', executable: true/false },
    ...
  ]
  ```
- **Benefits**:
  - No shell script execution required
  - Clear visibility of what files are loaded
  - Supports nested directory structures
  - Handles executable permissions

### 3. Initialization of CTF Filesystem
- **Function**: `initializeCTFFilesystem()`
- **Location**: `index.html`
- **Purpose**: Automatically loads all challenges when the emulator boots
- **Behavior**:
  - Creates a `README.md` file in the root directory with CTF instructions
  - Loads all challenges sequentially using `setupChallengeFiles()`
  - Executes automatically after the Linux kernel boots and shell prompt appears
  - Shows success message when complete

### 4. Modified Emulator Boot Sequence
- **Location**: Serial output listener in `initEmulator()` function
- **Change**: When the emulator detects the shell prompt (boot complete), it now:
  1. Sets status to "Setting up CTF environment..."
  2. Calls `initializeCTFFilesystem()`
  3. Updates status to "Linux is ready" when complete
  4. Shows success message: `[✓ CTF environment ready! Type "ls" to see available challenges]`

### 5. Removed Components
- **Setup Scripts**: No longer fetch or execute setup.sh files
- **Script Execution**: All challenge files are pre-created in the repository
- **Dynamic Generation**: Challenges are loaded as-is from ctf-collection folder

### 6. Helper Functions
- **escapeShell()**: Safely escapes strings for shell commands
- **safeBase64Encode()**: Encodes content to base64, handling UTF-8 characters
- **fetchChallengeFile()**: Fetches a file from the ctf-collection folder
- All functions are used for secure file transfer to the emulator

## Expected Behavior

### On Emulator Boot
When the user opens the page and the emulator boots:
1. Linux kernel loads (~10-30 seconds depending on connection)
2. Shell prompt appears
3. CTF filesystem initialization begins automatically
4. A `README.md` file is created in the root with instructions
5. All challenges are loaded with their pre-created files
6. User sees: `[✓ CTF environment ready! Type "ls" to see available challenges]`

### When User Runs `ls`
The user should see:
```
README.md
challenge1-hidden-files
challenge4-log-forensics
challenge7-script-debugger
challenge8-intrusion-analysis
```

### When User Navigates to a Challenge
1. User runs: `cd challenge1-hidden-files`
2. User runs: `ls` to see challenge files
3. User runs: `cat README.md` to read instructions
4. All challenge files are already present and ready to use

## Benefits

1. **Security**: No shell scripts are executed during loading
2. **Transparency**: All files are visible in the repository
3. **Simplicity**: Direct file copying without script execution
4. **Reliability**: No dynamic file generation means consistent behavior
5. **GitHub Pages Compatible**: Works with static file hosting
6. **Easier Maintenance**: Challenge files can be edited directly in the repository

## File Structure

```
TerminalBox/
├── index.html (main application)
├── ctf-collection/
│   ├── challenge1-hidden-files/
│   │   ├── README.md
│   │   └── mystery_dir/
│   │       ├── .cache
│   │       ├── .config/settings
│   │       ├── .secrets/.clue
│   │       ├── .secrets/.hidden_treasure
│   │       └── ... (more files)
│   ├── challenge4-log-forensics/
│   │   ├── README.md
│   │   └── access.log
│   ├── challenge7-script-debugger/
│   │   ├── README.md
│   │   ├── broken_script.sh
│   │   └── .solution_script.sh
│   └── challenge8-intrusion-analysis/
│       ├── README.md
│       └── incident/
│           ├── .bash_history
│           ├── logs/auth.log
│           └── ... (more files)
└── README.md
```

## Testing

To test the integration:
1. Start a local web server: `python3 -m http.server 8000`
2. Open http://localhost:8000 in a browser
3. Wait for the emulator to boot
4. Type `ls` in the command input and click "Run"
5. Verify that README.md and all challenge directories are listed
6. Navigate to a challenge: `cd challenge1-hidden-files`
7. Run `ls -la` to see all files including hidden ones
8. Verify that all challenge files are present

## Security Notes

- No shell scripts (setup.sh) are executed during challenge loading
- All files are fetched via HTTP and written directly to the emulator filesystem
- File contents are base64-encoded for safe transfer
- Shell command parameters are properly escaped using `escapeShell()`
- Only pre-existing files from ctf-collection are loaded
