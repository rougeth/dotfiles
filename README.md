# dotfiles

My dotfiles.

### How to use

> Make sure to backup your old dotfiles.

* Go to tmp folder: `$ cd /tmp`
* Clone the repository: `$ git clone --recursive https://github.com/rougeth/dotfiles.git && cd dotfiles`
* Copy all the dotfiles (except .git/ and .gitmodules) to the $HOME directory: ```$ cp -r `ls -d .??* | egrep -v '(.git$|.gitmodules)'` $HOME ```
* Ubuntu users: `$ echo source ~/.bash_profile > ~/.bashrc`
