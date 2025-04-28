#!/bin/bash
# TODO: Separate each monitor into a new oject, and add icons for what programs are open in each monitor
# NOTE: If I don't like that, remove the icons and separate by monitor instead.

source "$CONFIG_DIR/colors.sh" #For loading the defined colors

focused_workspace="$(aerospace list-workspaces --focused)"

workspaces="$(aerospace list-workspaces --all)"

for workspace in $workspaces; do

  workspace_icons=""
  windows="$(aerospace list-windows --workspace $workspace --json | jq -r '.[]."app-name"')"
  for window in $windows; do
    workspace_icons+="$($CONFIG_DIR/plugins/icon_map.sh "$window")"
  done
  sketchybar --add item "workspace$workspace" left \
    --set "workspace$workspace" label="$workspace_icons" label.font="sketchybar-app-font:Regular:16.0" \
    icon="$workspace:" icon.font="SF Pro:Semibold:15.0"

  if [[ $workspace == $focused_workspace ]]; then
    sketchybar --set "workspace$workspace" background.color="$HIGHLIGHT_COLOR" drawing=on
  elif [[ -z $workspace_icons ]]; then
    sketchybar --set "workspace$workspace" drawing=off
  else
    sketchybar --set "workspace$workspace" background.color="$ITEM_BG_COLOR" drawing=on
  fi
done
