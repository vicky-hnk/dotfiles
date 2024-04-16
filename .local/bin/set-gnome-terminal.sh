#!/bin/bash

# load terminal profile "vicky"
dconf load /org/gnome/terminal/legacy/profiles:/ < ~/.gnome_terminal_settings.txt

#set wallpaper
#gsettings set org.gnome.desktop.background picture-uri 'file:///~/.local/share/themes/wallpaper/lavender_blue_ball.jpg'
#gsettings set org.gnome.desktop.background picture-options 'zoom'

#set themes and icons
# Set the GTK theme
gsettings set org.gnome.desktop.interface gtk-theme '~/.local/share/themes/WhiteSur-Light-solid/'
# Set the icon theme
gsettings set org.gnome.desktop.interface icon-theme '~.local/share/icons/WhiteSur'
