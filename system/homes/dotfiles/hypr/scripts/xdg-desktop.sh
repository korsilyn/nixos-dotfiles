#!/bin/bash
sleep 1
pkill -f -e xdg-desktop-portal-hyprland
pkill -f -e xdg-desktop-portal-gtk
pkill -f -e xdg-desktop-portal-wlr
pkill -f -e xdg-desktop-portal
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/libexec/xdg-desktop-portal-gtk &
sleep 2
/usr/libexec/xdg-desktop-portal &