# Dotfiles Setup with Nix & Home Manager

## Quick Overview

This guide helps you set up a portable dotfiles system using Nix that:
- Works on macOS and Linux
- Installs all dependencies with one command
- Manages Homebrew declaratively (macOS only)
- Uses symlinks for configs (edit directly, no rebuilding)
- Handles macOS system settings
- Manages secrets securely

## One-Command Setup

### macOS (with system settings & Homebrew)
```bash
# 1. Install Nix (only manual step)
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. Clone dotfiles
git clone https://github.com/you/dotfiles ~/dotfiles
cd ~/dotfiles

# 3. Run nix-darwin (installs Homebrew, packages, system settings, symlinks)
darwin-rebuild switch --flake .
```

### Linux (or macOS without system management)
```bash
# 1. Install Nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. Clone dotfiles
git clone https://github.com/you/dotfiles ~/dotfiles
cd ~/dotfiles

# 3. Run Home Manager
home-manager switch --flake .
```

That's it! Your dotfiles are symlinked and editable. Only re-run when adding/removing packages or changing system settings.

## Understanding devShells vs Home Manager

### ❌ devShells (NOT for dotfiles)
```nix
devShells.default = pkgs.mkShell {
  packages = [ tmux neovim ];  # Only available inside 'nix develop'
};
```
- Requires running `nix develop` every time
- Packages NOT globally available
- Good for project-specific development, NOT dotfiles

### ✅ Home Manager (for dotfiles)
```nix
homeConfigurations."user" = home-manager.lib.homeManagerConfiguration {
  modules = [{
    home.packages = [ tmux neovim ];  # Globally available!
  }];
};
```
- Run `home-manager switch` once
- Packages globally available everywhere
- Perfect for dotfiles

## The Hybrid Approach

**Home Manager/nix-darwin handles:**
- Installing packages (globally available)
- Creating initial symlinks
- macOS system settings
- Homebrew installation & cask management

**You handle (no rebuild needed):**
- Daily config edits (edit files directly in `~/dotfiles`)
- Keybindings, colors, settings
- All dotfile tweaks

Changes to your config files apply **immediately** because they're symlinked!

## Complete Single-File flake.nix

Everything in one file - Home Manager, nix-darwin, and all configurations:

```nix
{
  description = "Portable dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    darwin.url = "github:LnL7/nix-darwin";
    
    # Make all inputs use the same nixpkgs (prevents conflicts & saves disk space)
    # Without this, each tool would use different nixpkgs versions
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, darwin, ... }: 
  let
    # Shared packages across all platforms
    commonPackages = pkgs: with pkgs; [
      tmux neovim starship atuin btop bat yazi lazygit nushell
      rustup  # Use rustup for version switching (rustup default stable/nightly)
      ghcup   # Use ghcup for version switching (ghcup install ghc 9.4.7)
    ];
  in {
    # ==========================================
    # macOS: nix-darwin + Home Manager together
    # ==========================================
    darwinConfigurations.myMac = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        # Embed Home Manager as a nix-darwin module
        home-manager.darwinModules.home-manager
        
        ({ pkgs, lib, ... }: {
          # Homebrew (installed automatically by nix-darwin)
          homebrew = {
            enable = true;
            onActivation.cleanup = "zap";  # Remove unlisted packages
            
            brews = [
              # CLI tools not in nixpkgs (rare)
            ];
            
            casks = [
              "raycast"
              "ghostty"
              # GUI apps work better via Homebrew
            ];
          };
          
          # macOS system settings
          system.defaults = {
            dock = {
              autohide = true;
              autohide-delay = 0.0;
              show-recents = false;
              persistent-apps = [];  # Clear dock
            };
            
            NSGlobalDomain = {
              _HIHideMenuBar = true;
              AppleShowAllExtensions = true;
              "com.apple.swipescrolldirection" = false;
            };
            
            finder = {
              AppleShowAllExtensions = true;
              ShowPathbar = true;
              ShowStatusBar = true;
            };
            
            trackpad = {
              Clicking = true;  # Tap to click
              TrackpadThreeFingerDrag = true;
            };
          };
          
          # Enable nix-daemon
          services.nix-daemon.enable = true;
          
          # Home Manager configuration (embedded)
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.yourusername = { pkgs, lib, ... }: {
            home.stateVersion = "24.05";
            
            # Install packages (globally available)
            home.packages = commonPackages pkgs;
            
            # Run symlink script on activation
            home.activation.linkDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
              $DRY_RUN_CMD bash ${./symlink}
            '';
          };
        })
      ];
    };
    
    # ==========================================
    # Linux: Standalone Home Manager
    # ==========================================
    homeConfigurations."user@linux" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      
      modules = [({ pkgs, lib, ... }: {
        home.username = "user";
        home.homeDirectory = "/home/user";
        home.stateVersion = "24.05";
        
        # Same packages as macOS
        home.packages = commonPackages pkgs;
        
        # Run symlink script
        home.activation.linkDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
          $DRY_RUN_CMD bash ${./symlink}
        '';
      })];
    };
    
    # Optional: macOS without system management (just Home Manager)
    homeConfigurations."user@mac" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      
      modules = [({ pkgs, lib, ... }: {
        home.username = "yourusername";
        home.homeDirectory = "/Users/yourusername";
        home.stateVersion = "24.05";
        
        home.packages = commonPackages pkgs;
        
        home.activation.linkDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
          $DRY_RUN_CMD bash ${./symlink}
        '';
      })];
    };
  };
}
```

**Commands:**
```bash
# macOS with full system management
darwin-rebuild switch --flake .#myMac

# Linux
home-manager switch --flake .#user@linux

# macOS without system management
home-manager switch --flake .#user@mac
```

## Alternative: Split Configuration Files

For larger configs, split into multiple files:

```
dotfiles/
├── flake.nix           # Main flake
├── home.nix            # Shared home-manager config
├── darwin.nix          # macOS-specific settings
└── linux.nix           # Linux-specific settings
```

**flake.nix:**
```nix
{
  outputs = { nixpkgs, home-manager, darwin, ... }: {
    darwinConfigurations.myMac = darwin.lib.darwinSystem {
      modules = [ 
        ./darwin.nix 
        home-manager.darwinModules.home-manager
        {
          home-manager.users.user = import ./home.nix;
        }
      ];
    };
    
    homeConfigurations."user@linux" = home-manager.lib.homeManagerConfiguration {
      modules = [ ./home.nix ./linux.nix ];
    };
  };
}
```

**home.nix (shared):**
```nix
{ pkgs, lib, ... }: {
  home.stateVersion = "24.05";
  
  home.packages = with pkgs; [
    tmux neovim starship atuin btop bat yazi
  ];
  
  home.activation.linkDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD bash ${./symlink}
  '';
}
```

**darwin.nix:**
```nix
{ pkgs, ... }: {
  homebrew.enable = true;
  homebrew.casks = [ "raycast" "ghostty" ];
  system.defaults.dock.autohide = true;
}
```

## Cross-Platform Conditional Logic

### Understanding `follows` (Input Pinning)

The `follows` keyword ensures all parts of your system use the same nixpkgs version:

```nix
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  darwin.url = "github:LnL7/nix-darwin";
  home-manager.url = "github:nix-community/home-manager";
  
  # Force everything to use the same nixpkgs
  darwin.inputs.nixpkgs.follows = "nixpkgs";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
};
```

**Without `follows`:**
- Your flake uses nixpkgs from Dec 1
- darwin uses its own nixpkgs from Nov 15
- home-manager uses its own nixpkgs from Nov 20
- Result: 3 different nixpkgs versions, potential conflicts, more disk space

**With `follows`:**
- Everything uses your nixpkgs from Dec 1
- All packages compatible (built from same source)
- Less disk space, shared cache, faster builds

**TL;DR:** It's like saying "Hey darwin and home-manager, use MY nixpkgs, don't bring your own!"

### In Nix
```nix
home.packages = with pkgs; [
  # Common packages
  tmux neovim starship
] ++ lib.optionals pkgs.stdenv.isDarwin [
  # macOS-only
] ++ lib.optionals pkgs.stdenv.isLinux [
  # Linux-only
];
```

### In Symlink Script
```bash
#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Setting up macOS..."
    # macOS specific
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Setting up Linux..."
    # Linux specific
fi

# Common symlinks
ln -sf $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
ln -sf $HOME/dotfiles/zshrc $HOME/.zshrc
```

## Managing Development Tools

### Use Nix Packages (Recommended)
```nix
home.packages = with pkgs; [
  # Instead of rustup install script
  cargo
  rustc
  rust-analyzer
  
  # Instead of ghcup install script
  ghc
  cabal-install
  haskell-language-server
];
```

**Benefits:**
- Declarative, reproducible
- Works in 10+ years
- No internet required after first install
- No curl scripts that can break

### If You Need Version Switching
```nix
home.packages = with pkgs; [
  rustup  # Official rustup, but installed via Nix
  ghcup   # Official ghcup, but installed via Nix
];
```

Then use normally:
```bash
rustup default stable
ghcup install ghc 9.4.7
```

**Avoid:** Running install scripts in activation hooks - defeats Nix's purpose and isn't reproducible.

## Secrets Management

### Option 1: Private Git Submodule
```bash
# Add private repo as submodule
git submodule add git@github.com:you/dotfiles-secrets.git secrets

# When cloning
git clone --recurse-submodules https://github.com/you/dotfiles
```

### Option 2: Separate Private Repo (Recommended)
```bash
# Public dotfiles
git clone https://github.com/you/dotfiles ~/dotfiles

# Private secrets
git clone git@github.com:you/dotfiles-private ~/dotfiles-private
```

**In your symlink script:**
```bash
# Setup secrets if private repo exists
if [ -d "$HOME/dotfiles-private" ]; then
    ln -sf $HOME/dotfiles-private/.ssh $HOME/
    ln -sf $HOME/dotfiles-private/.env $HOME/
    echo "Secrets linked"
fi
```

### Option 3: Encrypted with git-crypt
```bash
brew install git-crypt
git-crypt init

# Encrypt specific files
echo "secrets/.env filter=git-crypt diff=git-crypt" >> .gitattributes
echo ".ssh/* filter=git-crypt diff=git-crypt" >> .gitattributes
```

### Option 4: sops-nix (Advanced)
```nix
inputs.sops-nix.url = "github:Mic92/sops-nix";

# Secrets encrypted in repo, decrypted at activation
```

## Directory Structure

### Remove Leading Dots
Store configs without dots in your dotfiles repo (easier to see):

```
~/dotfiles/ (public repo)
├── flake.nix           # Nix configuration
├── flake.lock          # Lock file (commit this)
├── symlink             # Symlink script
├── tmux.conf           # No leading dot!
├── zshrc               # No leading dot!
├── nvim/
├── ghostty/
└── starship.toml

~/dotfiles-private/ (private repo, optional)
├── .env
├── .ssh/
└── secrets/
```

Your symlink script creates the dotted versions:
```bash
ln -sf $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
ln -sf $HOME/dotfiles/zshrc $HOME/.zshrc
```

## Daily Workflow

```bash
# Edit configs directly - changes apply immediately!
vim ~/dotfiles/tmux.conf
vim ~/dotfiles/nvim/init.lua
vim ~/dotfiles/zshrc

# Changes are live - no rebuild needed
# Symlinks mean edits in ~/dotfiles affect ~/ immediately

# Only rebuild when adding/removing packages or changing system settings
home-manager switch --flake .       # Linux or standalone macOS
darwin-rebuild switch --flake .     # macOS with system management
```

## Automatic Package Cleanup

### Garbage Collection

When you remove a package from your flake and rebuild, it's removed from your PATH but stays in `/nix/store` until garbage collected.

**Automatic cleanup (recommended):**
```nix
{
  darwinConfigurations.myMac = darwin.lib.darwinSystem {
    modules = [{
      # Weekly automatic garbage collection
      nix.gc = {
        automatic = true;
        interval = { Weekday = 7 };  # Sunday (0 = Sunday, 1 = Monday, etc.)
        options = "--delete-older-than 30d";
      };
      
      # Optimize store (deduplicate files)
      nix.optimise.automatic = true;
    }];
  };
}
```

**For Linux:**
```nix
{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
```

**Manual garbage collection:**
```bash
# Remove packages no longer in any profile
nix-collect-garbage

# Delete old generations too
nix-collect-garbage -d

# Delete older than specific time
nix-collect-garbage --delete-older-than 30d
```

### Homebrew Cleanup

```nix
homebrew = {
  enable = true;
  onActivation.cleanup = "zap";  # Remove ALL unlisted packages/casks immediately
  # OR
  onActivation.cleanup = "uninstall";  # Remove unlisted but keep dependencies
};
```

With `cleanup = "zap"`, removing a cask from your list and running `darwin-rebuild switch` immediately uninstalls it.

### What Happens When You Remove a Package

```nix
# Before
home.packages = with pkgs; [ tmux neovim bat ];

# After - remove bat
home.packages = with pkgs; [ tmux neovim ];
```

Run `darwin-rebuild switch --flake .`:
1. `bat` removed from PATH (can't run it anymore)
2. Files stay in `/nix/store/` temporarily
3. Weekly GC deletes it after 30 days (if configured)
4. OR manually run `nix-collect-garbage -d`

### Recommended Setup

```nix
{
  # Weekly automatic cleanup
  nix.gc = {
    automatic = true;
    interval = { Weekday = 7 };
    options = "--delete-older-than 30d";
  };
  
  # Optimize store weekly (saves disk space)
  nix.optimise = {
    automatic = true;
    interval = { Weekday = 0 };
  };
  
  # Homebrew cleanup on every rebuild
  homebrew.onActivation.cleanup = "zap";
}
```

**Benefits:**
- Rebuilds stay fast (GC runs in background)
- 30-day window allows rollback if needed
- Automatic disk space management
- Homebrew casks removed immediately

## When to Rebuild

**Re-run only when:**
- Adding/removing packages in `home.packages`
- Installing new Homebrew casks
- Changing macOS system settings
- Modifying `flake.nix` structure

**No rebuild needed for:**
- Editing config files (tmux, zsh, nvim, starship, etc.)
- Changing colors, keybindings, aliases
- Daily dotfile tweaks
- Any changes to files in `~/dotfiles/`

## Key Benefits

✅ One command setup on new machines  
✅ Edit dotfiles directly, changes apply instantly  
✅ Works identically on macOS and Linux  
✅ Declarative package management  
✅ Homebrew installed & managed by Nix (macOS)  
✅ macOS system settings as code  
✅ Secrets kept separate/encrypted  
✅ Reproducible - same setup in 10 years  
✅ No manual Homebrew installation needed  
✅ Cross-platform without duplication  

## Common Issues

### "Home Manager not found"
```bash
nix run home-manager/master -- switch --flake .
```

### "Darwin-rebuild not found"
```bash
nix run nix-darwin -- switch --flake .
```

### Packages not globally available
- You might be using `devShells` instead of `home.packages`
- Use Home Manager's `home.packages` for global availability

### Changes not applying
- Check symlinks: `ls -la ~/.tmux.conf`
- Should point to `~/dotfiles/tmux.conf`
- If it's a copy, Home Manager isn't using `mkOutOfStoreSymlink` or your script
