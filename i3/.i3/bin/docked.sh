#!/bin/bash
xrandr --output DP-1 --auto --primary &&\
xrandr --output LVDS-0 --off &&\
xrandr --output DP-0 --auto --right-of DP-1
