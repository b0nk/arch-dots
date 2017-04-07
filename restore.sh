# restore some shi- stuff

# conky
mkdir -p ~/.config/conky/
cp -f -u ./conky.conf ~/.config/conky/conky.conf

# zsh
cp -f -u ./.zshrc ~/.zshrc
cp -f -u ./.zprofile ~/.zprofile

# x
cp -f -u ./.xinitrc ~/.xinitrc 

# tint2
mkdir -p ~/.config/tint2
cp -f -u ./tint2rc ~/.config/tint2/tint2rc

# openbox
mkdir -p ~/.config/openbox
cp -f -u ./autostart ~/.config/openbox/autostart
# obmenu-generator
mkdir -p ~/.config/obmenu-generator/
cp -f -u ./config.pl ~/.config/obmenu-generator/config.pl
cp -f -u ./schema.pl ~/.config/obmenu-generator/schema.pl

# wallpaper
cp -f -u ./wall.png ~/wall.png
cp -f -u ./fehbg ~/.fehbg

# pacaur
mkdir -p ~/.config/pacaur/config
cp -f -u ./config ~/.config/pacaur/config
