# dotfiles

My dotfiles for Ubuntu (I think it also runs well on OSX).

## How to use

> **Make sure to backup your old dotfiles**.

* Go to tmp folder: `cd /tmp`
* Clone the repository: `git clone --recursive https://github.com/rougeth/dotfiles.git && cd dotfiles`
* Copy all the dotfiles (except .git/ and .gitmodules) to the $HOME directory: ```cp -r `ls -d .??* | egrep -v '(.git$|.gitmodules)'` $HOME ```

## XMonad

* Install XMonad and everything I need to configure it: `sudo apt-get install xmonad libghc-xmonad-contrib-dev libghc-xmonad-dev suckless-tools`
* Install and update cabal: `sudo apt-get install cabal-install -y && cabal update`
* Install xmobar: `cabal install xmobar`
* (Optional) Install gtk-chtheme to change gtk theme (only one that works for me): `sudo apt-get install gtk-chtheme`
* To-do:
    * Add support to macbook air function keys.

## VIM

### Plugins

[Here](https://github.com/rougeth/dotfiles/blob/master/.vim/vimrc#L15).

### Configuring Vim

* Create a link for ~/.vim/vimrc: `ln -s ~/.vim/vimrc ~/.vimrc`
* Install the plugins: `vim +BundleInstall +qall`
* Configuring Powerline symbols:

```bash
cd /tmp
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
```
