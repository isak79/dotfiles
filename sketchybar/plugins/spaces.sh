#!/usr/bin/env sh

sketchybar --add event aerospace_workspace_change
# sketchybar --set "$NAME" background.drawing="$SELECTED"

##### Adding Mission Control Space Indicators #####
for sid in $(aerospace list-workspaces --all); do
  sketchybar --add item "space.$sid" left \
		--subscribe "space.$sid" aerospace_workspace_change \
		--set "space.$sid" \
    icon="$sid" \
    icon.padding_left=7 \
    icon.padding_right=7 \
    background.color=0x40ffffff \
    background.height=20 \
    label.drawing=off \
		click_script="aerospace workspace $sid" \
    script="$SCRIPTS_DIR /aerospacer.sh $sid"
done
sketchybar --add item chevron left \
					 --set chevron icon= label.drawing=off \
