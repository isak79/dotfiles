#!/bin/sh

POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"
POPUP_OFF="sketchybar --set front_app popup.drawing=off"

KILL_APP="kill -9 \$(ghostty )"

sketchybar --add item front_app left \
           --set front_app icon.drawing=off\
					 			 click_script="$POPUP_CLICK_SCRIPT" \
					 			 script="$SCRIPTS_DIR/front_app_script.sh" \
           --subscribe front_app front_app_switched \
					 --add item 									front_app.close popup.front_app \
					 --set front_app.close 				icon="Kill app" \
					 															click_script="aerospace close; $POPUP_OFF"
