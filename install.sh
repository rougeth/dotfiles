#!/bin/bash


# -----------------------------------------------------------------------------
# => Copying dotfiles
# -----------------------------------------------------------------------------

echo
echo "=> Copying .dotfiles to $HOME"

ROOT=`pwd`
DOTFILES_OLD=~/.dotfiles-old/`date +%d:%m:%y-%H:%M`
mkdir -p "$DOTFILES_OLD"

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
        mkdir -p $(dirname "$DOTFILES_OLD/.$FILE")
        mv "$DEST" "$DOTFILES_OLD/.$FILE"
    fi

    cp -r "$ROOT/.$FILE" "$HOME"
done

echo "Done."
echo

# -----------------------------------------------------------------------------
# => Vim settings
# -----------------------------------------------------------------------------
echo
echo "=> Installing vim plugins"

if [ -e "$HOME"/.vimrc ]
then
    mv "$HOME"/.vimrc "$DOTFILES_OLD"/.vimrc
fi
ln -s ~/.vim/vimrc ~/.vimrc

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

echo "Done."
echo

# -----------------------------------------------------------------------------
# => Gnome-terminal settings
# -----------------------------------------------------------------------------

echo
echo "=> Changing gnome-terminal settings"

"$ROOT"/gnome-terminal-colors/install.sh

echo "Done."
echo

# -----------------------------------------------------------------------------
# => Guake terminal settings
# -----------------------------------------------------------------------------

echo
echo "=> Changing guake settings"

gconftool-2 -s -t string /apps/guake/style/font/palette \
    $(cat "$ROOT"/gnome-terminal-colors/colors/palette)
gconftool-2 -s -t string /apps/guake/style/font/palette "Ubuntu Mono 12"
gconftool-2 -s -t int /apps/guake/style/background/transparency 0 

echo "Done."
