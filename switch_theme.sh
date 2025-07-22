#!/bin/bash

THEME_DIR=~/.config/kitty/themes
FAVOURITE_THEME_WEIGHT=0.5  # Value between 0 and 1

DARK_THEMES=(AdventureTime.conf Afterglow.conf AlienBlood.conf Argonaut.conf Arthur.conf Atom.conf ayu.conf ayu_mirage.conf Belafonte_Night.conf BirdsOfParadise.conf Blazer.conf Borland.conf Broadcast.conf Brogrammer.conf C64.conf Chalk.conf Chalkboard.conf Ciapre.conf Cobalt2.conf Dark_pastel.conf Desert.conf DjangoSmooth.conf Dracula.conf Espresso.conf Flat.conf FrontEndDelight.conf FunForrest.conf Galaxy.conf Grape.conf Grass.conf Harper.conf Highway.conf Hipster_Green.conf Homebrew.conf Hurtado.conf Hybrid.conf IC_Green_PPL.conf IC_Orange_PPL.conf idleToes.conf IR_Black.conf Japanesque.conf LiquidCarbon.conf LiquidCarbonTransparent.conf LiquidCarbonTransparentInverse.conf Material.conf MaterialDark.conf Medallion.conf Misterioso.conf Molokai.conf MonaLisa.conf Monokai_Soda.conf N0tch2k.conf Neopolitan.conf Neutron.conf Night_Owlish_Light.conf NightLion_v1.conf NightLion_v2.conf Obsidian.conf Ocean.conf Ollie.conf PaulMillr.conf PencilDark.conf Pnevma.conf Pro.conf Red_Alert.conf Red_Sands.conf Rippedcasts.conf Royal.conf SeaShells.conf Seti.conf Shaman.conf Slate.conf Smyck.conf SoftServer.conf Spacedust.conf SpaceGray.conf SpaceGray_Eighties.conf SpaceGray_Eighties_Dull.conf Spring.conf Square.conf Sundried.conf Symfonic.conf Teerb.conf Thayer_Bright.conf Tomorrow_Night.conf Tomorrow_Night_Blue.conf Tomorrow_Night_Bright.conf Tomorrow_Night_Eighties.conf ToyChest.conf Treehouse.conf Twilight.conf Ubuntu.conf Urple.conf Vaughn.conf VibrantInk.conf WarmNeon.conf Wez.conf WildCherry.conf Wombat.conf 3024_Night.conf gruvbox.conf gruvbox_dark.conf Solarized_Dark.conf)
LIGHT_THEMES=(Belafonte_Day.conf ayu_light.conf PencilLight.conf Tomorrow.conf Novel.conf 3024_Day.conf gruvbox_light.conf Solarized_Light.conf Github.conf)
BLACKLISTED=(Github.conf)
FAVOURITE_LIGHT=()
FAVOURITE_DARK=(IC_Orange_PPL.conf Spacedust.conf)

filter_blacklisted() {
    local themes=("$@")
    local filtered=()
    for theme in "${themes[@]}"; do
        local is_blacklisted=false
        for blacklisted in "${BLACKLISTED[@]}"; do
            if [[ "$theme" == "$blacklisted" ]]; then
                is_blacklisted=true
                break
            fi
        done
        if [[ "$is_blacklisted" == false ]]; then
            filtered+=("$theme")
        fi
    done
    echo "${filtered[@]}"
}

get_random_theme() {
    local themes=("$@")
    local favourite_themes=()
    local non_favourite_themes=()

    if [[ "$MODE" == "dark" ]]; then
        declare -n fav_ref=FAVOURITE_DARK
    else
        declare -n fav_ref=FAVOURITE_LIGHT
    fi

    for theme in "${themes[@]}"; do
        local is_favourite=false
        for fav in "${fav_ref[@]}"; do
            if [[ "$theme" == "$fav" ]]; then
                is_favourite=true
                break
            fi
        done
        if [[ "$is_favourite" == true ]]; then
            favourite_themes+=("$theme")
        else
            non_favourite_themes+=("$theme")
        fi
    done

    # Apply weight logic
    if (( $(echo "$FAVOURITE_THEME_WEIGHT >= 1.0" | bc -l) )); then
        # Only use favourite themes
        themes=("${favourite_themes[@]}")
    elif (( $(echo "$FAVOURITE_THEME_WEIGHT <= 0.0" | bc -l) )); then
        # Only use non-favourite themes
        themes=("${non_favourite_themes[@]}")
    else
        # Weighted random selection
        local rand=$(echo "scale=2; $RANDOM / 32767" | bc) # random number between 0 & 1 upto 2 decimal places
        if (( $(echo "$rand < $FAVOURITE_THEME_WEIGHT" | bc -l) )) && [ ${#favourite_themes[@]} -gt 0 ]; then
            themes=("${favourite_themes[@]}")
        else
            themes=("${non_favourite_themes[@]}")
        fi
    fi

    # Return random theme from selected pool
    if [ ${#themes[@]} -gt 0 ]; then
        echo "${themes[RANDOM % ${#themes[@]}]}"
    else
        echo ""
    fi
}

if [[ "$1" == "dark" || "$1" == "light" ]]; then
    MODE="$1"
else
    COLOR_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)
    MODE=$([[ "$COLOR_SCHEME" == "'prefer-dark'" ]] && echo "dark" || echo "light")
fi

if [[ "$MODE" == "dark" ]]; then
    declare -n THEMES_REF=DARK_THEMES
else
    declare -n THEMES_REF=LIGHT_THEMES
fi

FILTERED_THEMES=($(filter_blacklisted "${THEMES_REF[@]}"))
CHOSEN_THEME=$(get_random_theme "${FILTERED_THEMES[@]}")

if [ -n "$CHOSEN_THEME" ]; then
    kitty @ set-colors -a "$THEME_DIR/$CHOSEN_THEME"
    echo "Applied $MODE theme: ${CHOSEN_THEME%.conf}"
else
    echo "No valid themes available after filtering."
fi