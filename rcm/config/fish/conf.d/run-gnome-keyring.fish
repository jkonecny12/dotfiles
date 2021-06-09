if test "sway" = "$DESKTOP_SESSION"; and which gnome-keyring-daemon &>/dev/null
    set -x (gnome-keyring-daemon --start | string split "=")
end
