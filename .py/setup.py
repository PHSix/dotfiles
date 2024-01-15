import os
import platform
from typing import Dict


ALL_COMMON_FOLDERS = [
    ".config/wezterm",
    ".config/kitty",
    ".config/alacritty",
    ".config/emacs",
    ".config/yazi",
    ".vim",
    ".zshrc",
    ".p10k.zsh",
    ".tmux.conf",
    ".ideavimrc",
]


OSX_FOLDERS_MAP: Dict[str, str] = {
    ".config/wezterm": ".config/wezterm_osx",
}


def shell_call(cmd: str):
    print("execing cmd: {cmd}".format(cmd=cmd))
    try:
        os.system(cmd)
    except:
        print("exec failed")


def get_source_folder(f: str) -> str:
    if platform.system() == "Darwin":
        return OSX_FOLDERS_MAP.get(f) or f
    return f


def link_file(source: str, target: str):
    absPath = os.path.expanduser(target)
    if os.path.exists(absPath):
        print("{path} is exists.".format(path=absPath))
        return
    shell_call("ln -s {source} {target}".format(source=source, target=absPath))


if __name__ == "__main__":
    dotfile_env = os.environ.get("DOTFILES_PATH")

    if dotfile_env == "" or dotfile_env == None:
        print("please expect your `DOTFILES_PATH` environment variable.")
        exit(1)

    path = os.path.abspath(dotfile_env)

    # prepare
    shell_call("mkdir ~/.config")

    for f in ALL_COMMON_FOLDERS:
        link_file(
            "{dotfiles_path}/{source_folder}".format(
                dotfiles_path=path, source_folder=get_source_folder(f)
            ),
            "~/{folder}".format(folder=f),
        )

    print("setup finish")
