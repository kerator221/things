# I dont really like this thing, but I dont know how to do it the right 'Nix' way

# Finds keyboard and pick only first
KEYBOARD=$(hyprctl devices | grep -A1 "Keyboard at" | grep -v "Keyboard at" | grep -i "keyboard" | head -1)
KBR=$(echo "$KEYBOARD" | tr -s ' \t\n' ' ')

# Switch layout
hyprctl switchxkblayout $KBR next

# Finds current keyboard layout
LAYOUT=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap') # ai slop but working

# Send notification
notify-send "Language: $LAYOUT"