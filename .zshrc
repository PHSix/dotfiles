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

######### plugins ###########
export ZSH_PLUGIN_REPO_PREFIX=git@github.com:
export PLUGIN_PATH=$HOME/.zsh-plugins
# export ZSH_PLUGIN_REPO_PREFIX=https://github.com/
plugin_install() {
	tmp=$1
	owner=$(echo "$tmp" | cut -d/ -f1)
	repo=$(echo "$tmp" | cut -d/ -f2)
	startup_file=$2

	if [ ! -d $PLUGIN_PATH/$repo ]; then
		git clone $ZSH_PLUGIN_REPO_PREFIX$owner/$repo.git $PLUGIN_PATH/$repo
	fi
	if [ -n "$startup_file" ]; then
		source $PLUGIN_PATH/$repo/$startup_file
	else
		source $PLUGIN_PATH/$repo/$repo.plugin.zsh
	fi
}

# plugin_install "jeffreytse/zsh-vi-mode" "zsh-vi-mode.plugin.zsh"
plugin_install "zdharma-continuum/fast-syntax-highlighting"
plugin_install "marlonrichert/zsh-autocomplete"
plugin_install "zsh-users/zsh-completions"
plugin_install "zsh-users/zsh-autosuggestions"

######### vi mode #########

bindkey -v
bindkey ^P up-history
bindkey ^N down-history
bindkey ^E vi-end-of-line
bindkey ^A vi-beginning-of-line
bindkey ^F vi-forward-char
bindkey ^B vi-backward-char

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

autoload -Uz compinit
