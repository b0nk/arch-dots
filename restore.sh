#!/bin/sh
# restore the dots

OLDUSER=$(cat ./user)

# rename user in configs
sed -i "s/$OLDUSER/$USER/g" ./*glob*

# conky
mkdir -p ~/.config/conky/
cp -f ./conky.conf ~/.config/conky/conky.conf

# zsh
cp -f ./.zshrc ~/.zshrc
cp -f ./.zprofile ~/.zprofile

# x
cp -f ./.xinitrc ~/.xinitrc

# tint2
mkdir -p ~/.config/tint2
cp -f ./tint2rc ~/.config/tint2/tint2rc

# openbox
mkdir -p ~/.config/openbox
cp -f ./autostart ~/.config/openbox/autostart

# obmenu-generator
mkdir -p ~/.config/obmenu-generator/
cp -f ./config.pl ~/.config/obmenu-generator/config.pl
cp -f ./schema.pl ~/.config/obmenu-generator/schema.pl

# wallpaper
cp -f ./wall.png ~/wall.png
cp -f ./.fehbg ~/.fehbg

# mpv
mkdir -p ~/.config/mpv/
cp -f ./mpv.conf ~/.config/mpv/mpv.conf

# xfetch
mkdir -p ~/.config/neofetch/
cp -f ./xfetch.conf ~/.config/neofetch/config.conf
