# dotfiles

My dotfiles.

### How to use

> **Make sure to backup your old dotfiles**.

* Go to tmp folder: `cd /tmp`
* Clone the repository: `git clone --recursive https://github.com/rougeth/dotfiles.git && cd dotfiles`
* Copy all the dotfiles (except .git/ and .gitmodules) to the $HOME directory: ```cp -r `ls -d .??* | egrep -v '(.git$|.gitmodules)'` $HOME ```


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

### iTerm colors

`open "init/Hybrid.itermcolors"`

### Sublime text 3 preferences

`cp -r init/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User/Preferences.sublime-settings 2> /dev/null`

---

> .osx script based on [Mathias Bynens](https://github.com/mathiasbynens/dotfiles/blob/master/.osx)'s script.
