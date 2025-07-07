#!/bin/bash

THEME_DIR=~/.config/kitty/kitty-themes/themes
DARK_THEME=Elemental.conf
LIGHT_THEME=Solarized_Light.conf

COLOR_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)

if [[ "$COLOR_SCHEME" == "'prefer-dark'" ]]; then
    kitty @ set-colors -a "$THEME_DIR/$DARK_THEME"
else
    kitty @ set-colors -a "$THEME_DIR/$LIGHT_THEME"
fi
