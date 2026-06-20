. "$HOME/.cargo/env"

# Prompt
PROMPT="[%F{#eed49f}%n%f@%m %F{#7dc4e4}%1~%f]$ "

export XDG_HOME_CONFIG=$HOME/.config
export XDG_CONFIG_HOME=$HOME/.config
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
export PATH="${HOME}/myBinaries:${PATH}"
export PATH="/opt/homebrew/Cellar/openjdk/25.0.2/bin/:${PATH}"
export PATH="/Users/isakhansen/.bun/bin:$PATH"
export EDITOR=nvim
export MPD_HOST="/Users/isakhansen/.config/mpd/socket"


if [[ ! -d "$ZINIT_HOME" ]]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi

function username() {
	pass show $1 | awk '/user/ {print $2}'
}

# Keybinds
function zvm_after_init ()
{
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^O' clear-screen
source <(sk --shell zsh --shell-bindings)
}

# Zsh plugins
source "${ZINIT_HOME}/zinit.zsh"
zinit light zsh-users/zsh-syntax-highlighting
zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Snippets
zinit snippet OMZP::git

autoload -U compinit && compinit


zinit cdreplay -q


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

# Aliases
alias c=cdi
alias v=nvim
alias cat=bat
alias ls='ls --color'
alias t=tmux
alias oc=opencode
alias pdf="fd -t f \"\\.*(pdf|epub|mobi)$\" | sk | sed 's/\ /\\\ /g' | xargs open"
alias movie="fd -t f \"\\.(mkv|webm)$\" | sk | sed 's/\ /\\\ /g' | xargs mpv"
alias q="pi --model big-pickle -p --no-session"
alias nm="neomutt"


# Shell integrations
eval "$(zoxide init --cmd cd zsh)"
eval "$(spotify_player generate zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f "/Users/isakhansen/.ghcup/env" ] && . "/Users/isakhansen/.ghcup/env" # ghcup-env
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
eval "$(direnv hook zsh)"
