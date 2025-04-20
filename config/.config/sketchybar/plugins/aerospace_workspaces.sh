#!/bin/bash
# TODO: Separate each monitor into a new oject, and add icons for what programs are open in each monitor
# NOTE: If I don't like that, remove the icons and separate by monitor instead.
# TODO: Instead of doing front_app_switched do every second or two. Shouldn't be too expensive.A
# TODO: Also add all these files to git. Add a symlink to zshrs too. Want all these files on git to make sure I don't accidentally mess them up

source "$CONFIG_DIR/colors.sh" #For loading the defined colors

num_monitors="$(aerospace list-monitors --count)"
focused_workspace="$(aerospace list-workspaces --focused)"

for ((monitor = 1; monitor <= num_monitors; monitor++)); do
  workspaces="$(aerospace list-workspaces --monitor $monitor)"
  (sketchybar --add item $monitor left \
    --set "$monitor" label="M$monitor:$focused_workspace")

  for workspace in $workspaces; do

    workspace_icons=""
    windows="$(aerospace list-windows --workspace $workspace --json | jq -r '.[]."app-name"')"
    for window in $windows; do
      workspace_icons+="$($CONFIG_DIR/plugins/icon_map.sh "$window")"
    done
    sketchybar --add item "workspace$workspace" left \
      --set "workspace$workspace" label=$workspace \
      icon="$workspace_icons" icon.font="sketchybar-app-font:Regular:16.0" \
      icon.position=right
    if [[ $workspace == $focused_workspace ]]; then
      sketchybar --set "workspace$workspace" background.color="$HIGHLIGHT_COLOR"
    else
      sketchybar --set "workspace$workspace" background.color="$ITEM_BG_COLOR"
    fi
  done
done
