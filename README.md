# dotfiles

My dotfiles.

### How to use

> **Make sure to backup your old dotfiles**.

* Go to tmp folder: `$ cd /tmp`
* Clone the repository: `$ git clone --recursive https://github.com/rougeth/dotfiles.git && cd dotfiles`
* Copy all the dotfiles (except .git/ and .gitmodules) to the $HOME directory: ```$ cp -r `ls -d .??* | egrep -v '(.git$|.gitmodules)'` $HOME ```


### Configuring Vim

* Create a link for ~/.vim/vimrc: `$ ln -s ~/.vim/vimrc ~/.vimrc`
* Install the plugins: `$ vim +BundleInstall +qall`
* Configuring Powerline symbols:

```bash
$ cd /tmp
$ wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
$ wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
$ mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
$ fc-cache -vf ~/.fonts
$ mkdir -p ~/.config/fontconfig/conf.d/
$ mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
```

### iTerm colors

[Hybrid.itermcolors](https://github.com/w0ng/vim-hybrid?#iterm2)

`$ curl -L https://gist.github.com/luan/6362811/raw/Hybrid.itermcolors | open`

### Sublime text 3 preferences

[Preferences.sublime-settings](https://gist.github.com/rougeth/9311370/).

For OS X users:

```
$ cd /tmp && curl -L https://gist.github.com/rougeth/9311370/raw/Preferences.sublime-settings
$ cp /tmp/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User/Preferences.sublime-settings
```
---

> .osx script based on [Mathias Bynens](https://github.com/mathiasbynens/dotfiles/blob/master/.osx)'s script.
