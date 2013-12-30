# dotfiles
My dotfiles for an Ubuntu (also runs well on OSX) set up.

## How to use
* I'm sure that exists a better way to do it

```
cd /tmp
git clone https://github.com/rougeth/dotfiles.git && cd dotfiles/
sudo rm -r .git/ README.md
shopt -s dotglob
mv * ~/
```
