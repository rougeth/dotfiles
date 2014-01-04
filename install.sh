#!/bin/bash
# I'm sure that exists a better way to do it
sudo rm -r .git/ README.md
profile_path=$HOME/.gconf/apps/gnome-terminal/profiles
mv $profile_path/Default $profile_path/.Default.backup
mv gnome-terminal-profile $profile_path/Default
shopt -s dotglob
cp -r * $HOME
