import os
import platform

ALL_COMMON_FOLDERS = [
    ".config/kitty",
    ".config/starship.toml",
    ".config/alacritty",
    ".config/emacs",
    ".config/yazi",
    ".vim",
    ".zshrc",
    ".p10k.zsh",
    ".tmux.conf",
    ".ideavimrc",
    ".npmrc",
]

LINUX_FOLDERS = [
    ".config/wezterm",
    ".config/fontconfig"
]

OSX_FOLDERS = [
    ".config/wezterm_osx:.config/wezterm"
];


def shell_call(cmd: str):
    print("execing cmd: {cmd}".format(cmd=cmd))
    try:
        _ = os.system(cmd)
    except:
        print("exec failed")

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

    cwd = os.path.abspath(dotfile_env)

    # prepare
    shell_call("mkdir ~/.config")
    link_folders = ALL_COMMON_FOLDERS[:];
    if platform.system() == 'Darwin':
      link_folders.extend(OSX_FOLDERS)
    elif platform.system() == 'Linux':
      link_folders.extend(LINUX_FOLDERS)

    for f in link_folders:
      ps = f.split(':')
      source = "{}/{}".format(cwd, f)
      target = "~/{}".format(ps[0])
      if len(ps) != 1:
        target = "~/{}".format(ps[1])

      link_file(source,target)

      # link_file(
      #     "{dotfiles_path}/{source_folder}".format(
      #         dotfiles_path=cwd, source_folder=f
      #     ),
      #     "~/{folder}".format(folder=f),
      # )

    print("setup finish")
