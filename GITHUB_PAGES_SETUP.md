# GitHub Pages Setup Guide

This document provides step-by-step instructions for enabling GitHub Pages hosting for the TerminalBox repository.

## Overview

This repository is pre-configured for GitHub Pages hosting with the following setup:
- Main application accessible at the root URL
- Disk images accessible at `/disk-images/`
- No Jekyll processing (`.nojekyll` file present)
- SEO-friendly URLs with proper `index.html` files

## Quick Start: Enable GitHub Pages

### Step 1: Access Repository Settings

1. Go to your GitHub repository: `https://github.com/yourusername/TerminalBox` (replace with your actual username)
2. Click on **Settings** (in the top repository menu)
3. In the left sidebar, click on **Pages** (under "Code and automation")

### Step 2: Configure GitHub Pages

1. Under **Source**, select **Deploy from a branch**
2. Under **Branch**:
   - Select your branch from the dropdown (e.g., `main` or `copilot/host-disk-images-github-pages`)
   - Select **/ (root)** as the folder
   - Click **Save**

3. GitHub will start building and deploying your site
   - This process typically takes 1-2 minutes
   - A blue banner will appear showing the deployment status

### Step 3: Access Your Live Site

Once deployed, your site will be available at:
- **Main URL**: `https://yourusername.github.io/TerminalBox/`
- **Disk Images**: `https://yourusername.github.io/TerminalBox/disk-images/`

(Replace `yourusername` with your actual GitHub username)

## What Gets Hosted

### Main Page (`/`)
- **File**: `index.html` (formerly `v86.html`)
- **URL**: `https://yourusername.github.io/TerminalBox/`
- **Purpose**: Linux terminal emulator interface
- **Features**: Full v86 emulator with autocomplete, session export, VGA screen

### Disk Images Directory (`/disk-images/`)
- **File**: `disk-images/index.html`
- **URL**: `https://yourusername.github.io/TerminalBox/disk-images/`
- **Purpose**: Browse and download CTF challenges
- **Contents**: 8 challenge disk images (.tar.gz files)

### Individual Disk Images
Each challenge is directly downloadable:
```
https://yourusername.github.io/TerminalBox/disk-images/challenge1-hidden-files.tar.gz
https://yourusername.github.io/TerminalBox/disk-images/challenge2-process-detective.tar.gz
https://yourusername.github.io/TerminalBox/disk-images/challenge3-network-navigator.tar.gz
https://yourusername.github.io/TerminalBox/disk-images/challenge4-log-forensics.tar.gz
https://yourusername.github.io/TerminalBox/disk-images/challenge5-permission-puzzle.tar.gz
https://yourusername.github.io/TerminalBox/disk-images/challenge6-archive-archaeology.tar.gz
https://yourusername.github.io/TerminalBox/disk-images/challenge7-script-debugger.tar.gz
https://yourusername.github.io/TerminalBox/disk-images/challenge8-intrusion-analysis.tar.gz
```

## Repository Structure Explained

```
TerminalBox/
├── index.html                 # Main page (GitHub Pages homepage)
│                              # URL: https://yourusername.github.io/TerminalBox/
│
├── disk-images/              # CTF challenges directory
│   ├── index.html            # Disk images browser
│   │                         # URL: https://yourusername.github.io/TerminalBox/disk-images/
│   ├── README.md             # Documentation
│   ├── challenge*.tar.gz     # Challenge files (8 total)
│   │                         # URL: https://yourusername.github.io/TerminalBox/disk-images/challenge*.tar.gz
│
├── .nojekyll                 # Disables Jekyll processing
│                              # Allows folders with special names (e.g., with spaces originally)
│
├── README.md                 # Repository documentation
├── OPTIMIZATIONS.md          # Performance documentation
└── GITHUB_PAGES_SETUP.md     # This file
```

## Technical Details

### Why `.nojekyll`?
The `.nojekyll` file tells GitHub Pages to skip Jekyll processing. This is important because:
- Faster deployment (no build step required)
- Prevents issues with special characters in file names
- Allows serving raw HTML, CSS, and JavaScript without transformation
- Essential for the original "Disk Images" folder (now renamed to "disk-images")

### Why Rename to `disk-images`?
The folder was renamed from "Disk Images" to "disk-images" for:
- **URL Compatibility**: Spaces in URLs require encoding (`%20`), which is ugly
- **Best Practices**: Kebab-case is standard for web URLs
- **Cross-Platform**: Works consistently across all operating systems
- **CLI Friendly**: No need to quote the path in terminal commands

### Why `index.html` Files?
Each directory with an `index.html` file becomes browsable:
- `/` → Serves `index.html` (the terminal emulator)
- `/disk-images/` → Serves `disk-images/index.html` (challenge browser)
- Clean URLs without `.html` extension

## Custom Domain (Optional)

If you want to use a custom domain (e.g., `terminalbox.example.com`):

### Step 1: Create CNAME File
Create a file named `CNAME` in the repository root:
```
terminalbox.example.com
```

### Step 2: Configure DNS
Add a DNS record with your domain provider:
- **Type**: CNAME
- **Name**: `terminalbox` (or `@` for root domain)
- **Value**: `yourusername.github.io`

### Step 3: Update GitHub Pages Settings
1. Go to Settings → Pages
2. Under "Custom domain", enter your domain
3. Check "Enforce HTTPS" (recommended)

## HTTPS and Security

GitHub Pages automatically provides HTTPS via Let's Encrypt:
- Free SSL certificate
- Automatic renewal
- Enforced HTTPS (after initial setup)

To enforce HTTPS:
1. Go to Settings → Pages
2. Check **Enforce HTTPS** checkbox
3. Wait a few minutes for certificate provisioning

## Updating Your Site

Any commit pushed to the configured branch automatically triggers a deployment:

```bash
# Make changes to files
git add .
git commit -m "Update disk images"
git push origin main  # or your configured branch

# GitHub Pages will automatically rebuild and deploy
# Changes are live in 1-2 minutes
```

## Testing Locally

You can test the GitHub Pages site locally before deploying:

### Method 1: Simple HTTP Server (Python)
```bash
cd /path/to/TerminalBox
python3 -m http.server 8000

# Visit: http://localhost:8000
# Disk images: http://localhost:8000/disk-images/
```

### Method 2: Using Jekyll (if you add Jekyll later)
```bash
gem install jekyll bundler
bundle exec jekyll serve

# Visit: http://localhost:4000
```

## Troubleshooting

### Site Not Deploying
- Check Settings → Pages for error messages
- Ensure the branch and folder are correctly selected
- Verify the branch has the latest commits pushed
- Wait 2-3 minutes for build completion

### 404 Errors
- Ensure file names match exactly (case-sensitive on Linux)
- Check that `index.html` exists in directories
- Verify paths don't have typos

### Disk Images Not Downloading
- Check browser console for CORS errors (shouldn't happen with GitHub Pages)
- Verify files exist in the repository
- Test direct URLs to individual files

### Changes Not Appearing
- Clear browser cache (Ctrl+Shift+R or Cmd+Shift+R)
- Wait for GitHub Pages deployment to complete
- Check that you pushed to the correct branch

## URL Updates Required

After enabling GitHub Pages, update the placeholder URLs in:

### 1. README.md
Replace `yourusername` with your actual GitHub username:
```markdown
Visit the live instance: https://yourusername.github.io/TerminalBox/
```

### 2. disk-images/index.html
Update the example URLs in the "Direct Download URLs" section

### 3. disk-images/README.md
Update the GitHub Pages URLs section

## Verification Checklist

After enabling GitHub Pages, verify:

- [ ] Main page loads: `https://yourusername.github.io/TerminalBox/`
- [ ] Terminal emulator works (waits for boot, accepts commands)
- [ ] Disk images page loads: `https://yourusername.github.io/TerminalBox/disk-images/`
- [ ] Challenge list displays correctly
- [ ] Download buttons work for each challenge
- [ ] Direct URLs to `.tar.gz` files work
- [ ] Navigation between pages works (links)
- [ ] HTTPS is enabled (green padlock in browser)

## Advanced Configuration

### Custom 404 Page
Create a `404.html` file in the repository root:
```html
<!DOCTYPE html>
<html>
<head>
    <title>Page Not Found - TerminalBox</title>
</head>
<body>
    <h1>404 - Page Not Found</h1>
    <p><a href="/">Return to TerminalBox</a></p>
</body>
</html>
```

### GitHub Actions for Automated Deployment
You can use GitHub Actions for more control over deployment:

Create `.github/workflows/pages.yml`:
```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./
```

## Support and Resources

- **GitHub Pages Documentation**: https://docs.github.com/en/pages
- **Repository Issues**: https://github.com/MrMichel93/TerminalBox/issues
- **v86 Documentation**: https://github.com/copy/v86

## Summary

Your repository is now fully configured for GitHub Pages hosting. Simply:
1. Enable GitHub Pages in repository settings
2. Select the branch and root folder
3. Wait 1-2 minutes for deployment
4. Access your site at the provided URL

All disk images will be immediately accessible via direct URLs for easy integration with other applications and platforms.
