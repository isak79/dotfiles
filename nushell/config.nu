# Nushell Config File
#
# version = "0.99.1"

# For more information on defining custom themes, see
# https://www.nushell.sh/book/coloring_and_theming.html
# And here is the theme collection
# https://github.com/nushell/nu_scripts/tree/main/themes

# External completer example
# let carapace_completer = {|spans|
#     carapace $spans.0 nushell ...$spans | from json
# }

# The default config record. This is where much of your global configuration is setup.


alias v = nvim
alias c = clear
alias grep = rg
alias cat = bat
alias pcat = bat -p
alias l = eza --color=always --icons=always --long --git --no-filesize --no-time --no-user --no-permissions

source ~/.config/nushell/env.nu
source ~/.cache/carapace/init.nu
use ~/.cache/starship/init.nu
use '/Users/isakhansen/.config/broot/launcher/nushell/br' *
source ~/.zoxide.nu
source ~/.local/share/atuin/init.nu

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

alias cd = z
