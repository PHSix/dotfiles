fish_vi_key_bindings
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

function fish_mode_prompt --description 'Displays the current mode'
    switch $fish_bind_mode
        case default
            # set_color --bold --background red white
            # echo '[N]'
        case insert
            # set_color --bold --background blue white
            # echo '[I]'
        case visual
            # set_color --bold --background magenta white
            # echo '[V]'
    end
    set_color normal
    echo -n ' '
end


set -x all_proxy "socks://127.0.0.1:1089"
set -x http_proxy "127.0.0.1:8889"
set -x https_proxy "127.0.0.1:8889"
set -x no_proxy "localhost,127.0.0.1"
set -x RUSTUP_DIST_SERVER https://mirrors.ustc.edu.cn/rust-static
set -x RUSTUP_UPDATE_ROOT https://mirrors.ustc.edu.cn/rust-static/rustup
set -x PATH $PATH:$HOME/.cargo/bin
set -x FLUTTER_STORAGE_BASE_URL "https://mirrors.tuna.tsinghua.edu.cn/flutter"
set -x ANDROID_HOME "/home/ph/Android/Sdk"
set -x PUB_HOSTED_URL "https://mirrors.tuna.tsinghua.edu.cn/dart-pub"
set -x EDITOR 'nvim'
set -x FZF_DEFAULT_OPTS "--height 60% --layout=reverse"
set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'


function fish_user_key_bindings
	fzf_key_bindings
end
bind -M insert \cf fzf
bind -M insert \co fzf-history-widget
function ra
	ranger --choosedir=$HOME/.config/ranger/.rangerdir
	set LASTDIR (cat $HOME/.config/ranger/.rangerdir)
	cd $LASTDIR
end


# function j
    # # cd (autojump $argv)
    # cd (autojump $argv)
# end



set -gx AUTOJUMP_SOURCED 1

# set user installation path
if test -d ~/.autojump
    set -x PATH ~/.autojump/bin $PATH
end

# Set ostype, if not set
if not set -q OSTYPE
    set -gx OSTYPE (bash -c 'echo ${OSTYPE}')
end


# enable tab completion
complete -x -c j -a '(autojump --complete (commandline -t))'


# set error file location
if test (uname) = "Darwin"
    set -gx AUTOJUMP_ERROR_PATH ~/Library/autojump/errors.log
else if test -d "$XDG_DATA_HOME"
    set -gx AUTOJUMP_ERROR_PATH $XDG_DATA_HOME/autojump/errors.log
else
    set -gx AUTOJUMP_ERROR_PATH ~/.local/share/autojump/errors.log
end

if test ! -d (dirname $AUTOJUMP_ERROR_PATH)
    mkdir -p (dirname $AUTOJUMP_ERROR_PATH)
end


# change pwd hook
function __aj_add --on-variable PWD
    status --is-command-substitution; and return
    autojump --add (pwd) >/dev/null 2>>$AUTOJUMP_ERROR_PATH &
end


# misc helper functions
function __aj_err
    # TODO(ting|#247): set error file location
    echo -e $argv 1>&2; false
end

# default autojump command
function j
    switch "$argv"
        case '-*' '--*'
            autojump $argv
        case '*'
            set -l output (autojump $argv)
            # Check for . and attempt a regular cd
            if [ $output = "." ]
                cd $argv
            else
                if test -d "$output"
                    set_color red
                    echo $output
                    set_color normal
                    cd $output
                else
                    __aj_err "autojump: directory '"$argv"' not found"
                    __aj_err "\n$output\n"
                    __aj_err "Try `autojump --help` for more information."
                end
            end
    end
end


function cl
    clear
end
function n
    neofetch
end

function lg
    lazygit
end
function ls --wraps=lsd --description 'alias ls lsd'
  lsd  $argv;
end
function l --wraps=lsd --description 'alias l ll'
  ll  $argv;
end
function gl --wraps="git clone" --description 'alias gl git clone'
    git clone $argv
end
function mk --wraps="mkdir" --description 'alias mk mkdir'
    mkdir $argv
end

function cn --wraps="touch" --description 'alias cn touch'
    touch $argv
end

function f --wraps="fanyi" --description 'alias f fanyi'
    fanyi $argv
end
