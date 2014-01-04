#!/bin/bash
# I'm sure that exists a better way to do it
sudo rm -r .git/ README.md
profile_path=$HOME/.gconf/apps/gnome-terminal/profiles
cp -rf  $profile_path/Default $profile_path/.Default.backup
cp -rf gnome-terminal-profile $profile_path/Default
rm gnome-terminal-profile
shopt -s dotglob
cp -r * $HOME
