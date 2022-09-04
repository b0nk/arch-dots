#!/bin/sh
# backup the dots

# conky
cp -f -u ~/.config/conky/conky.conf  ./

# zsh
cp -f -u ~/.zshrc ./
cp -f -u ~/.zprofile ./

# x
cp -f -u ~/.xinitrc ./

# tint2
cp -f -u ~/.config/tint2/tint2rc ./

# openbox
cp -f -u ~/.config/openbox/autostart ./
# obmenu-generator
cp -f -u ~/.config/obmenu-generator/config.pl ./
cp -f -u ~/.config/obmenu-generator/schema.pl ./

# wallpaper
cp -f -u ~/wall.png ./
cp -f -u ~/.fehbg ./

# mpv
cp -f -u ~/.config/mpv/mpv.conf ./

# xfetch
cp -f -u ~/.config/neofetch/config.conf ./xfetch.conf

echo "$USER" > user
