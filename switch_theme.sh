#!/bin/bash

THEME_DIR=~/.config/kitty/themes

DARK_THEMES=(Obsidian.conf Dracula.conf Monokai.conf gruvbox_dark.conf WildCherry.conf Monokai_Soda.conf)
LIGHT_THEMES=(Solarized_Light.conf Belafonte_Day.conf ayu_light.conf)

get_random_theme() {
    local themes=("$@")
    echo "${themes[$RANDOM % ${#themes[@]}]}"
}

COLOR_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)

if [[ "$COLOR_SCHEME" == "'prefer-dark'" ]]; then
    CHOSEN_DARK_THEME=$(get_random_theme "${DARK_THEMES[@]}")
    kitty @ set-colors -a "$THEME_DIR/$CHOSEN_DARK_THEME"
    echo "Applied theme: ${CHOSEN_DARK_THEME%?????}"
else
    CHOSEN_LIGHT_THEME=$(get_random_theme "${LIGHT_THEMES[@]}")
    kitty @ set-colors -a "$THEME_DIR/$CHOSEN_LIGHT_THEME"
    # echo "Applied theme: $(basename "$CHOSEN_LIGHT_THEME")"
    echo "Applied theme: ${CHOSEN_LIGHT_THEME%?????}"
fi
