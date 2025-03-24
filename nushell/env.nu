$env.__zoxide_hooked = true

$env.config.show_banner = false

$env.config.edit_mode = 'vi'

$env.path ++= [/opt/homebrew/opt/openjdk@17/bin]
$env.path ++= [/Users/isakhansen/python]
$env.path ++= [/opt/homebrew/bin]
$env.path ++= [/opt/homebrew/sbin]
$env.path ++= [/usr/local/bin]
$env.path ++= [/Users/isakhansen/.atuin/bin/]
$env.path ++= [/Users/isakhansen/.cargo/bin/]
# path add /nix/store/
# path add /nix/var/nix/profiles/default/bin
# path add /Users/isakhansen/.nix-profile/bin
# path add /run/current-system/sw/bin
# path add /nix/var/nix/profiles/default/bin
# path add /usr/local/bin


$env.EDITOR = 'nvim'
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
$env.NIX_CONF_DIR = '/Users/isakhansen/.config/nix/'
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

zoxide init nushell | save -f ~/.zoxide.nu
