#!/usr/bin/env sh

# Color Palette
# Kanagawa Palette (primarily from the dark 'wave' or 'dragon' themes)
# Hex values obtained from https://github.com/rebelot/kanagawa.nvim
BLACK=0xff1F1F28      # sumiInk1 (Default background)
WHITE=0xffDCD7BA      # fujiWhite (Default foreground)
MAGENTA=0xff957FB8    # oniViolet (Statements and Keywords)
BLUE=0xff7E9CD8       # crystalBlue (Functions and Titles)
CYAN=0xff7AA89F       # waveAqua2 (Types) or springBlue (0xff7FB4CA) can also be used
GREEN=0xff98BB6C      # springGreen (Strings)
YELLOW=0xffE6C384     # carpYellow (Identifiers)
ORANGE=0xffFFA066     # surimiOrange (Constants, imports, booleans)
RED=0xffC34043        # autumnRed (Git Delete) or samuraiRed (0xffE82424 for errors)
BAR_COLOR=0xfA16161D  # sumiInk0 (Dark background, good for bar)
COMMENT=0xff727169    # fujiGray (Comments)

# If you were using Tokyonight Day and want a Kanagawa light theme,
# you would need to refer to Kanagawa's light theme variant if available,
# or adjust the dark theme colors to lighter shades.
# The main Kanagawa theme is dark. For example:
# LIGHT_BACKGROUND=0xffDCD7BA # fujiWhite
# LIGHT_FOREGROUND=0xff1F1F28 # sumiInk1
# etc.

TRANSPARENT=0x00000000

# General bar colors
ICON_COLOR=$WHITE # Color of all icons
LABEL_COLOR=$WHITE # Color of all labels

ITEM_DIR="$HOME/.config/sketchybar/items"
PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

FONT="d2CodingLigature nerd font" # Ensure this font is installed

PADDINGS=3 # Consider adjusting if needed for new color contrast

POPUP_BORDER_WIDTH=2 # Adjusted from 12, as Kanagawa tends to be more subtle
POPUP_CORNER_RADIUS=8 # Adjusted from 11
POPUP_BACKGROUND_COLOR=$BLACK # sumiInk1, could also use waveBlue1 (0xff223249) for popups
POPUP_BORDER_COLOR=$COMMENT # fujiGray, could also use sumiInk4 (0xff54546D) for borders

CORNER_RADIUS=1 # Original: 1
BORDER_WIDTH=2 # Original: 2, consider 1 for a finer look with Kanagawa

SHADOW=on # Keep or disable based on preference with new palette
