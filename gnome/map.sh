
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
for i in {1..9}; do
    gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-$i '[]'
    gsettings set org.gnome.shell.keybindings switch-to-application-$i '[]'
done
