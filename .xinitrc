#!/bin/sh

# Set random wallpaper and its colors

WALLPAPER=$(find ~/img/Wallpapers/ -maxdepth 1 -type f | shuf -n 1)
# WALLPAPER=$(find ~/img/Wallpapers/old/ -maxdepth 1 -type f | shuf -n 1)
# WALLPAPER=$(find ~/img/Wallpapers/sonic/ -maxdepth 1 -type f | shuf -n 1)

wal --cols16 -i "$WALLPAPER" -n
feh --bg-fill "$(< "${HOME}/.cache/wal/wal")" --no-fehbg

# -------------
# Reload things
# -------------

# Xresources
"$HOME/scripts/mkXresources.sh"
xrdb -merge "$HOME/.Xresources"
rm "$HOME/.Xresources"

# dunst
ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
killall dunst
dunst >/dev/null 2>&1 &

# Zed
[ -x "$HOME/app/zed-theme-wal/generate_theme" ] && "$HOME/app/zed-theme-wal/generate_theme" --mode readability

# Startpage
# starttree.py
(cd "$HOME/app/startpage" && ./update-startpage.sh)

# Zathura
ln -sf ~/.cache/wal/zathurarc ~/.config/zathura/zathurarc

# Discord
ln -s $HOME/.cache/wal/colors-discord.css $HOME/.config/vesktop/themes/pywal-vencord.theme.css

# Calibre
"$HOME/scripts/calibre.sh"

# Pywalfox
pywalfox update

# ------------
# Start things
# ------------

mpd && "$HOME/scripts/current_song.sh" &

picom -b &

redshift &

# ---------------------------------------------
# Hardware things (probably differs from yours)
# ---------------------------------------------

# Language Switcher
setxkbmap -layout us,ara -option grp:caps_toggle &

# Monitor
# xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off

# Stopping screen power saving
xset -dpms
xset s off

# Auto Locker after 10 min
xautolock -time 10 -notify 30 -notifier "notify-send 'Screen will lock in 30 seconds'" -locker slock &

# --------
# exec dwm
# --------

exec dwm

