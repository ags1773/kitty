#!/bin/bash

THEME_DIR="$HOME/.config/kitty/themes"

# Ensure theme directory exists
if [[ ! -d "$THEME_DIR" ]]; then
    echo "Theme directory $THEME_DIR does not exist"
    exit 1
fi

# Use nullglob to ensure empty array if no files match
shopt -s nullglob
THEME_FILES=("$THEME_DIR"/*.conf)

# Check if any themes exist
if [[ ${#THEME_FILES[@]} -eq 0 ]]; then
    echo "No themes found in $THEME_DIR"
    exit 1
fi

# Get user input from command-line argument
user_input="$1"

if [[ -z "$user_input" ]]; then
    # No input provided, select random theme
    RANDOM_THEME="${THEME_FILES[RANDOM % ${#THEME_FILES[@]}]}"
    echo "No search string provided, applying a random theme"
else
    # Find matching themes (case-insensitive)
    MATCHING_THEMES=()
    for theme in "${THEME_FILES[@]}"; do
        theme_name=$(basename "$theme" .conf)
        if [[ "${theme_name,,}" =~ ${user_input,,} ]]; then
            MATCHING_THEMES+=("$theme")
        fi
    done

    if [[ ${#MATCHING_THEMES[@]} -eq 0 ]]; then
        echo "No themes found matching '$user_input', applying a random theme"
        RANDOM_THEME="${THEME_FILES[RANDOM % ${#THEME_FILES[@]}]}"
    elif [[ ${#MATCHING_THEMES[@]} -eq 1 ]]; then
        RANDOM_THEME="${MATCHING_THEMES[0]}"
    else
        # Select random theme from matches
        RANDOM_THEME="${MATCHING_THEMES[RANDOM % ${#MATCHING_THEMES[@]}]}"
    fi
fi

kitty @ set-colors -a "$RANDOM_THEME" && echo "Applied theme: $(basename "$RANDOM_THEME" .conf)"