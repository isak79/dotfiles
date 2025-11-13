# SearXNG Native macOS Installation Guide

## Overview

This guide covers installing SearXNG natively on macOS without containers for better battery life and performance.

## Prerequisites

- macOS with Homebrew installed
- Python 3.14+ (installed via Homebrew)

## Installation Steps

### 1. Install Dependencies

```bash
brew install valkey
brew services start valkey
```

### 2. Install SearXNG and setup Python Virtual Environment

```bash
mkdir -p ~/Projects/
git clone git@github.com:searxng/searxng.git ~/Projects
cd ~/Projects/searxng/
python3 -m venv .searxng-venv
source ~/.searxng-venv/bin/activate
pip install -r requirements.txt
```

### 3. Configure SearXNG

```bash
# Generate a new secret key
openssl rand -hex 16
# Update the secret_key in settings.yml with the generated value
```

### 4. Create Launch Agent

```bash
cp /Users/isakhansen/dotfiles/searxng/searxng.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/searxng.plist
```

### 5. Manual Testing (Optional)

Before setting up the launch agent, test manually:
```bash
source ~/.searxng-venv/bin/activate
python -m searxng.server
```

Visit `http://127.0.0.1:8888` to verify it's working.

## Configuration Files

- **settings.yml**: Main SearXNG configuration
- **limiter.toml**: Rate limiting configuration  
- **searxng.plist**: macOS launch agent for auto-start


### Start/Stop SearXNG
```bash
# Start
launchctl load ~/Library/LaunchAgents/searxng.plist

# Stop
launchctl unload ~/Library/LaunchAgents/searxng.plist

# Check status
launchctl list | grep searxng
```
