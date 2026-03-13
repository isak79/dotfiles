. "$HOME/.cargo/env"

# Prompt
PS1="[%F{#eed49f}%n%f@%m]$ "

export XDG_HOME_CONFIG=$HOME/.config
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
export PATH="${HOME}/myBinaries:${PATH}"
export PATH="/opt/homebrew/Cellar/openjdk/25.0.2/bin/:${PATH}"
export EDITOR=nvim


if [[ ! -d "$ZINIT_HOME" ]]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi


# Keybinds
function zvm_after_init ()
{
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


# Shell integrations
eval "$(zoxide init --cmd cd zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f "/Users/isakhansen/.ghcup/env" ] && . "/Users/isakhansen/.ghcup/env" # ghcup-env
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
