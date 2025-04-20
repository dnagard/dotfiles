#!/bin/bash

sketchybar --add event aerospace_workspace_change

sketchybar --add item aerospace_workspaces left \
  --set aerospace_workspaces script="$PLUGIN_DIR/aerospace_workspaces.sh" \
  drawing=off \
  --subscribe aerospace_workspaces aerospace_workspace_change
