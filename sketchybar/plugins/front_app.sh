#!/bin/sh

POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar --add item front_app left \
           --set front_app icon.drawing=off\
					 			 click_script="$POPUP_CLICK_SCRIPT" \
					 			 script="$SCRIPTS_DIR/front_app_script.sh" \
           --subscribe front_app front_app_switched \
					 --add item 									front_app.close popup.front_app \
					 --set front_app.close 				icon="" \
					 															label="Kill app" \
