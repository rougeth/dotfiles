#!/bin/bash

# -----------------------------------------------------------------------------
# => Copying dotfiles
# -----------------------------------------------------------------------------

ROOT=`pwd`
DOTFILES_BACKUP=~/.dotfiles-backup/`date +%d:%m:%y-%H:%M`
mkdir -p "$DOTFILES_BACKUP"

DOTFILES=(
    bashrc
    bash_aliases
    bash_prompt
    gitconfig
    gitignore
    vim
)

for FILE in ${DOTFILES[*]} ; do
    DEST=~/".$FILE"

    # [ -e FILE ]: true if FILE exists
    # [ EXPR1 -a EXPR2 ]: true if both EXPR1 and EXPR2 are true
    # [ ! EXPR ]: true if EXPR is false
    # [ -L FILE ]: true if FILE is a symbolic link
    if [ -e "$DEST" -a ! -L "$DEST" ]
    then
        mkdir -p $(dirname "$DOTFILES_BACKUP/.$FILE")
        mv "$DEST" "$DOTFILES_BACKUP/.$FILE"
    fi

    cp -r "$ROOT/.$FILE" "$HOME"
done

# -----------------------------------------------------------------------------
# => Vim settings
# -----------------------------------------------------------------------------

if [ -e "$HOME"/.vimrc ]
then
    mv "$HOME"/.vimrc "$DOTFILES_BACKUP"/.vimrc
fi
ln -s ~/.vim/vimrc ~/.vimrc

vim +BundleInstall +qall

# Configuring Command-T
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb && make

# Configuring Powerline symbols
cd /tmp
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

# -----------------------------------------------------------------------------
# => Gnome-terminal settings
# -----------------------------------------------------------------------------

"$ROOT"/gnome-terminal-colors/install.sh
