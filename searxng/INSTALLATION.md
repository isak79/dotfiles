# SearXNG Native macOS Installation Guide

## Overview

This guide covers installing SearXNG natively on macOS without containers for better battery life and performance.

## Prerequisites

- macOS with Homebrew installed
- Python 3.14+ (installed via Homebrew)

## Installation Steps

### 1. Install Dependencies

```bash
brew install python redis
brew services start redis
```

### 2. Setup Python Virtual Environment

```bash
python3 -m venv ~/.searxng-venv
source ~/.searxng-venv/bin/activate
pip install searxng
```

### 3. Configure SearXNG

```bash
mkdir -p ~/.config/searxng
# Copy settings.yml from this directory to ~/.config/searxng/
cp /Users/isakhansen/dotfiles/searxng/settings.yml ~/.config/searxng/

# Generate a new secret key
openssl rand -hex 16
# Update the secret_key in settings.yml with the generated value
```

### 4. Create Launch Agent

The launch agent plist file is already created at `/Users/isakhansen/dotfiles/searxng/searxng.plist`.

To install it:
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

## Key Configuration Changes

- Redis URL: `redis://redis:6379/0` → `redis://localhost:6379/0`
- Bind address: `127.0.0.1` (local access only)
- Port: `8888`

## Management Commands

### Start/Stop SearXNG
```bash
# Start
launchctl load ~/Library/LaunchAgents/searxng.plist

# Stop
launchctl unload ~/Library/LaunchAgents/searxng.plist

# Check status
launchctl list | grep searxng
```

### View Logs
```bash
tail -f /tmp/searxng.log
```

### Update SearXNG
```bash
source ~/.searxng-venv/bin/activate
pip install --upgrade searxng
```

## Performance Benefits

- **Container VM**: 5-15% constant CPU usage
- **Native Python**: <1% CPU when idle
- **Battery impact**: Significant reduction vs container-based solutions

## Troubleshooting

1. **Redis not running**: `brew services start redis`
2. **Port 8888 in use**: Change port in `settings.yml`
3. **Permission issues**: Ensure proper ownership of config files
4. **Launch agent not working**: Check logs at `/tmp/searxng.log`

## Files Location

- Virtual environment: `~/.searxng-venv/`
- Configuration: `~/.config/searxng/`
- Launch agent: `~/Library/LaunchAgents/searxng.plist`
- Logs: `/tmp/searxng.log`

## Next Steps

1. Complete the installation by copying the plist file to LaunchAgents
2. Test the setup manually first
3. Enable auto-start with the launch agent
4. Configure browser search shortcuts to use your local SearXNG instance