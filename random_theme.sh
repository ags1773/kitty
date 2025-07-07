#!/bin/bash

THEME_DIR="$HOME/.config/kitty/themes"
THEME_FILES=("$THEME_DIR"/*.conf)

if [[ ${#THEME_FILES[@]} -eq 0 ]]; then
    echo "No themes found in $THEME_DIR"
    exit 1
fi

RANDOM_THEME="${THEME_FILES[RANDOM % ${#THEME_FILES[@]}]}"

kitty @ set-colors -a "$RANDOM_THEME" && echo "Applied theme: $(basename "$RANDOM_THEME")"
