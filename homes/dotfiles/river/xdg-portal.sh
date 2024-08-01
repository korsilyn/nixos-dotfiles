
# Upstream refuses to set XDG_CURRENT_DESKTOP so we have to.
systemctl --user set-environment XDG_CURRENT_DESKTOP=river
systemctl --user import-environment DISPLAY \
                                         WAYLAND_DISPLAY \
                                         XDG_CURRENT_DESKTOP

hash dbus-update-activation-environment 2>/dev/null && \
     dbus-update-activation-environment --systemd DISPLAY \
                                                  XDG_CURRENT_DESKTOP=river \
                                                  WAYLAND_DISPLAY
