. "$HOME/.cargo/env"

export XDG_HOME_CONFIG=$HOME/.config
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
export PATH="${HOME}/myBinaries:${PATH}"
export EDITOR=nvim


if [[ ! -d "$ZINIT_HOME" ]]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi




export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_OPTS="--preview 'bat {}'"
export FZF_DEFAULT_OPTS="--height 40% --border --color=bg+:#000000,fg+:#f5f5f5"

# Keybinds
function zvm_after_init ()
{
bindkey 'ç' fzf-cd-widget
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^O' clear-screen
bindkey '^R' fzf-history-widget
}

# Zsh plugins
source "${ZINIT_HOME}/zinit.zsh"
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode

# Snippets
zinit snippet OMZP::git

autoload -U compinit && compinit

zinit cdreplay -q

goto_binary ()
{
	cd $(dirname $(command -v $1))
}

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias v=nvim
alias cat=bat
alias ls='ls --color'
alias vpnIface='ifconfig -v | awk '\''/^[a-z]/ {iface=$1} /VPN: ProtonVPN/ {print iface; exit}'\'


# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f "/Users/isakhansen/.ghcup/env" ] && . "/Users/isakhansen/.ghcup/env" # ghcup-env
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
