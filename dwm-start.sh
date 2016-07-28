#!/bin/bash

xrdb -merge $HOME/.Xresources
xmodmap ~/.Xmodmap
setxkbmap -layout 'us,ru' -option 'grp:alt_shift_toggle'

hash chromium-browser && chromium-browser &

while true
do
	VOL=$(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')
	LOCALTIME=$(date +%H:%M)
	TEMP="$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))C"

	if acpi -a | grep off-line > /dev/null
	then
		BAT="V. $(acpi -b | awk '{ print $4 }' | tr -d ',')"
		xsetroot -name "$BAT t.$VOL $TEMP $LOCALTIME"
	else
		xsetroot -name "$VOL t.$TEMP $LOCALTIME"
	fi
	sleep 20s
done &

exec dwm
