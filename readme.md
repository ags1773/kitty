# Config for kitty terminal

Site: https://sw.kovidgoyal.net/kitty

## Theming

### Note:

- Place all theme files inside ./themes directory so that the scripts can pick them up
- add approptiate aliases in your `.bashrc`/`.zshrc` depending on which shell you use

```sh
# EXAMPLE FOR REFERENCE ONLY
alias kitty_open_dir="cd /home/amogh/.config/kitty"
alias kitty_theme_set="/home/amogh/.config/kitty/switch_theme.sh"
alias kitty_theme_random="/home/amogh/.config/kitty/random_theme.sh"
```

### Scripts

| Script                              | file name       | What it does                                                                                       |
| ----------------------------------- | --------------- | -------------------------------------------------------------------------------------------------- |
| `kitty_theme_random`                | random_theme.sh | Set a random theme                                                                                 |
| `kitty_theme_random <str>`          |                 | Set a theme that has the given keyword somewhere in its name                                       |
| [Example] `kitty_theme_random bela` |                 | Can set one of `Belafonte_Day`, `Belafonte_Night` or any other matches containing 'bela' at random |
| `kitty_theme_set`                   | switch_theme.sh | Sets a theme from a bunch of predefined themes depending on light/dark mode                        |
