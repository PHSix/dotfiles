# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##################################
############ alias ###############
##################################
alias cl=clear
alias lg=lazygit
alias gi=gitui
alias nvi=nvim

# git aliases
alias ga="git add"
alias gaa="git add --all"
alias gba="git branch --all"
alias gc="git commit --verbose"
alias gca="git commit --verbose --amend"
alias gcA="git commit --verbose --no-edit --amend"
alias gcb="git checkout -b"
alias grbc="git rebase --continue"
alias grba="git rebase --abort"
alias grbi="git rebase -i"
alias gm="git merge"
alias gP="git push"
alias gPf="git push -f"
alias gp="git pull"
alias gpr="git pull --rebase"
alias glogen="git log --oneline -n"
alias fetch="fastfetch"

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

if type "eza" > /dev/null; then
  # eza aliases
  alias ls='eza $eza_params'
  alias l='eza --git-ignore $eza_params'
  alias ll='eza --all --header --long $eza_params'
  alias llm='eza --all --header --long --sort=modified $eza_params'
  alias la='eza -lbhHigUmuSa'
  alias lx='eza -lbhHigUmuSa@'
  alias lt='eza --tree $eza_params'
  alias tree='eza --tree $eza_params'
fi

##################################


export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zshrc_local.zsh ] && source ~/.zshrc_local.zsh

[ ! -d ~/.local/share/zap ] && {
  echo "Installing zap package manager..."
  git clone -b master  https://github.com/zap-zsh/zap.git ~/.local/share/zap
}

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Load and initialise completion system
autoload -Uz compinit
compinit

# fzf-tab must loaded after compinit and before plugins
plug "Aloxaf/fzf-tab"

plug "zsh-users/zsh-autosuggestions"
plug 'romkatv/powerlevel10k'
plug "zap-zsh/zap-prompt"
# plug "zsh-users/zsh-syntax-highlighting"
plug "zdharma-continuum/fast-syntax-highlighting"
plug "jeffreytse/zsh-vi-mode"
plug "zsh-users/zsh-completions"

if [ -v MACHINE_NAME ]; then
  PROMPT=" [ %{$fg_bold[cyan]$MACHINE_NAME%{$reset_color ] $PROMPT"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
