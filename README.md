# dotfiles
My dotfiles for an Ubuntu (also runs well on OSX) set up.

## Bash dotfiles
* .bashrc: make sure to load .bash_aliases and .bash_prompt
* .bash_aliases: set all aliases
* .bash_prompt: set $PS1

## Installing

```
cd /tmp
git clone https://github.com/rougeth/dotfiles.git && cd dotfiles/
sudo rm -r .git/ README.md
shopt -s dotglob
mv * ~/
```
