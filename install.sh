#!/bin/bash


# -----------------------------------------------------------------------------
# => Copying dotfiles
# -----------------------------------------------------------------------------

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
    vimrc
)

for FILE in ${DOTFILES[*]} ; do
    DEST=~/".$FILE"

    # [ -e FILE ]: true if FILE exists
    # [ EXPR1 -a EXPR2 ]: true if both EXPR1 and EXPR2 are true
    # [ ! EXPR ]: true if EXPR is false
    # [ -L FILE ]: true if FILE is a symbolic link
    if [ -e "$DEST" -a ! -L "$DEST" ]
    then
        mkdir -p $(dirname "$DOTFILES_OLD/$FILE")
        mv "$DEST" "$DOTFILES_OLD/$FILE"
        echo "$DEST : $DOTFILES_OLD/$FILE"
    fi

    cp -r "$ROOT/.$FILE" "$HOME"
done


# -----------------------------------------------------------------------------
# => Gnome-terminal settings
# -----------------------------------------------------------------------------

"$ROOT"/gnome-terminal-colors/install.sh


# -----------------------------------------------------------------------------
# => Guake terminal settings
# -----------------------------------------------------------------------------
gconftool-2 -s -t string /apps/guake/style/font/palette \
    $(cat "$ROOT"/gnome-terminal-colors/colors/palette)
gconftool-2 -s -t string /apps/guake/style/font/palette "Ubuntu Mono 12"
gconftool-2 -s -t int /apps/guake/style/background/transparencyl 0 

