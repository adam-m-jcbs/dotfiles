#!/usr/bin/bash

#Download and install Powerline symbols locally (in user-space).  Needed for
#pretty powerline/vim-airline.

wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

mkdir -p ~/.local/share/fonts
mv PowerlineSymbols.otf ~/.local/share/fonts/

fc-cache -vf ~/.local/share/fonts/

mkdir -p ~/.config/fontconfig/conf.d
#mkdir -p ~/.fonts.conf.d/

mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
