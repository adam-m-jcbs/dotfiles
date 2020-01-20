# dotfiles
A repository for common configuration files, e.g. .bashrc, .vimrc, etc

## manual install
```
# from $HOME
ln -s /home/ajacobs/Codebase/dotfiles/init.vim .vimrc # for vim

mkdir -p /home/ajacobs/.config/nvim                   # for neovim
ln -s /home/ajacobs/Codebase/dotfiles/init.vim /home/ajacobs/.config/nvim/init.vim

ln -s /home/ajacobs/Codebase/dotfiles/.bash_profile
ln -s /home/ajacobs/Codebase/dotfiles/.bashrc

ln -s /home/ajacobs/Codebase/dotfiles/.zshrc
```
