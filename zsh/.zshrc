proxy(){
  export http_proxy=http://127.0.0.1:8889
  export https_proxy=http://127.0.0.1:8889
}
export EDITOR=nvim
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn


alias cl=clear
alias cn=touch
alias mk=mkdir
alias vi=nvim
alias lg=lazygit
alias n=neofetch
alias lg=lazygit
alias ra=ranger
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi




### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# zinit fast highlight
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma/fast-syntax-highlighting

zinit wait="1" lucid for \
  OMZ::plugins/sudo/sudo.plugin.zsh \
  OMZ::plugins/autojump/autojump.plugin.zsh\
  OMZ::plugins/fzf/fzf.plugin.zsh\
  OMZ::lib/completion.zsh


zinit wait='0' lucid for \
  OMZ::plugins/vi-mode/vi-mode.plugin.zsh\
  OMZ::lib/history.zsh

VI_MODE_SET_CURSOR=true

zinit ice lucid wait='0' atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice lucid wait='0' atload='zpcompinit; zpcdreplay'
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions

zinit ice lucid wait='1'
zinit light Aloxaf/fzf-tab

zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
