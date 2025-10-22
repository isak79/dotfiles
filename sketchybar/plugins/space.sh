#!/bin/sh

# sketchybar --add event aerospace_workspace_change
# sketchybar --set "$NAME" background.drawing="$SELECTED"

##### Adding Mission Control Space Indicators #####
for sid in "$(aerospace list-workspaces --all)"; do
  spaces=(
    space="$sid"
    icon="$sid"
    icon.padding_left=7
    icon.padding_right=7
    background.color=0x40ffffff
    background.corner_radius=5
    background.height=25
    label.drawing=off
    # script="$PLUGIN_DIR/space.sh"
  )
  sketchybar --add space space."$sid" left
done
