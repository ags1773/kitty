#!/bin/bash

THEME_DIR=~/.config/kitty/themes

DARK_THEMES=(Obsidian.conf Dracula.conf Monokai.conf gruvbox_dark.conf WildCherry.conf Monokai_Soda.conf)
LIGHT_THEMES=(Solarized_Light.conf Belafonte_Day.conf ayu_light.conf Github.conf)

get_random_theme() {
    local themes=("$@")
    echo "${themes[RANDOM % ${#themes[@]}]}"
}

if [[ "$1" == "dark" || "$1" == "light" ]]; then
    MODE="$1"
else
    COLOR_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)
    MODE=$([[ "$COLOR_SCHEME" == "'prefer-dark'" ]] && echo "dark" || echo "light")
fi

# Use name reference to select array
if [[ "$MODE" == "dark" ]]; then
    declare -n THEMES_REF=DARK_THEMES
else
    declare -n THEMES_REF=LIGHT_THEMES
fi

CHOSEN_THEME=$(get_random_theme "${THEMES_REF[@]}")
kitty @ set-colors -a "$THEME_DIR/$CHOSEN_THEME"
echo "Applied $MODE theme: ${CHOSEN_THEME%.conf}"
