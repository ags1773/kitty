#!/bin/bash

THEME_DIR=~/.config/kitty/themes

DARK_THEMES=(AdventureTime.conf Afterglow.conf AlienBlood.conf Argonaut.conf Arthur.conf Atom.conf ayu.conf ayu_mirage.conf Belafonte_Night.conf BirdsOfParadise.conf Blazer.conf Borland.conf Broadcast.conf Brogrammer.conf C64.conf Chalk.conf Chalkboard.conf Ciapre.conf Cobalt2.conf Dark_pastel.conf Desert.conf DjangoSmooth.conf DoomOne.conf Dracula.conf Espresso.conf Flat.conf FrontEndDelight.conf FunForrest.conf Galaxy.conf Grape.conf Grass.conf Harper.conf Highway.conf Hipster_Green.conf Homebrew.conf Hurtado.conf Hybrid.conf IC_Green_PPL.conf IC_Orange_PPL.conf idleToes.conf IR_Black.conf Japanesque.conf LiquidCarbon.conf LiquidCarbonTransparent.conf LiquidCarbonTransparentInverse.conf Material.conf MaterialDark.conf Medallion.conf Misterioso.conf Molokai.conf MonaLisa.conf Monokai_Soda.conf N0tch2k.conf Neopolitan.conf Neutron.conf Night_Owlish_Light.conf NightLion_v1.conf NightLion_v2.conf Obsidian.conf Ocean.conf Ollie.conf PaulMillr.conf PencilDark.conf Pnevma.conf Pro.conf Red_Alert.conf Red_Sands.conf Rippedcasts.conf Royal.conf SeaShells.conf Seti.conf Shaman.conf Slate.conf Smyck.conf SoftServer.conf Spacedust.conf SpaceGray.conf SpaceGray_Eighties.conf SpaceGray_Eighties_Dull.conf Spring.conf Square.conf Sundried.conf Symfonic.conf Teerb.conf Thayer_Bright.conf Tomorrow_Night.conf Tomorrow_Night_Blue.conf Tomorrow_Night_Bright.conf Tomorrow_Night_Eighties.conf ToyChest.conf Treehouse.conf Twilight.conf Ubuntu.conf Urple.conf Vaughn.conf VibrantInk.conf WarmNeon.conf Wez.conf WildCherry.conf Wombat.conf 3024_Night.conf gruvbox.conf gruvbox_dark.conf Solarized_Dark.conf)
LIGHT_THEMES=(Belafonte_Day.conf ayu_light.conf PencilLight.conf Tomorrow.conf Novel.conf 3024_Day.conf gruvbox_light.conf Solarized_Light.conf)
BLACKLISTED_LIGHT=(Github.conf)

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
