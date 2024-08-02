########### aliases ############
alias cl=clear

### git commands
alias gc="git clone"
alias gs="git status"
alias gp="git pull"
alias gP="git push"
if type "lazygit" > /dev/null; then
	alias lg="lazygit"
fi

### yazi auto change folder
if type "yazi" > /dev/null; then
	alias ra="yz"
	function yz() {
		tmp="$(mktemp -t "yazi-cwd.XXXXX")"
		yazi --cwd-file="$tmp"

		if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
			cd -- "$cwd"
		fi

		rm -f -- "$tmp"
	}
fi

### eza commands
if type "eza" > /dev/null; then
	alias ls='eza $eza_params'
	alias l='eza --git-ignore $eza_params'
	alias ll='eza --all --header --long $eza_params'
	alias llm='eza --all --header --long --sort=modified $eza_params'
	alias la='eza -lbhHigUmuSa'
	alias lx='eza -lbhHigUmuSa@'
	alias lt='eza --tree $eza_params'
	alias tree='eza --tree $eza_params'
fi


########### Env ###########
if type "nvim" > /dev/null; then
	export EDITOR=nvim
else
	export EDITOR=vim
fi

if type "yazi" > /dev/null; then
	alias ra="yz"
	function yz() {
		tmp="$(mktemp -t "yazi-cwd.XXXXX")"
		yazi --cwd-file="$tmp"
		if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
		fi
		rm -f -- "$tmp"
	}
fi
export XDG_CONFIG_HOME="$HOME/.config"

### use homebrew tuna.tsinghua mirror if brew is existd.
if type 'brew' > /dev/null; then
	export HOMEBREW_INSTALL_FROM_API=1
	export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
	export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
	export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
	export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
# zinit light marlonrichert/zsh-autocomplete
# zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
# zinit light marlonrichert/zsh-autocomplete

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# Load completions
autoload -Uz compinit && compinit
zinit light Aloxaf/fzf-tab

if type 'fzf' > /dev/null; then
	eval "$(fzf --zsh)"
fi


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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

if type "starship" > /dev/null; then
	eval "$(starship init zsh)"
fi

if type "zoxide" > /dev/null; then
	eval "$(zoxide init zsh)"
fi

if type "fnm" > /dev/null; then
	eval "$(fnm env --use-on-cd)"
fi

if [ -d "$HOME/.bun/bin" ]; then
	export PATH=$PATH:$HOME/.bun/bin
fi

if [ -d "$HOME/.npm-packages/bin" ]; then
	export PATH=$PATH:$HOME/.npm-packages/bin
fi

if [ -d "$HOME/.flutter/flutter" ]; then
	export FLUTTER_HOME=$HOME/.flutter/flutter
	export PATH=$PATH:$FLUTTER_HOME/bin
fi

autoload -Uz compinit
