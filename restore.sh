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

# openbox
mkdir -p ~/.config/openbox
cp -f ./autostart ~/.config/openbox/autostart

# wallpaper
cp -f ./wall.png ~/wall.png
cp -f ./.fehbg ~/.fehbg

# mpv
mkdir -p ~/.config/mpv/
cp -f ./mpv.conf ~/.config/mpv/mpv.conf

# xfetch
mkdir -p ~/.config/neofetch/
cp -f ./xfetch.conf ~/.config/neofetch/config.conf
