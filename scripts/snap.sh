#!/bin/bash
# Simulate Aero-Snap (for one monitor).
#
# The xdpyinfo command which is used actually returns [width]x[height],
# but because of the division by 2 it only returns one value, which is
# half the width of the screen.

function snap()
{
    #get screen width and divide it by two
    HALFSCREEN=`xdpyinfo | grep dimension | awk '{ print $2 / 2 }'`
    case $1 in
        R)  #place window on right half of screen
            X=$HALFSCREEN
            W=$HALFSCREEN
	echo $HALFSCREEN
            ;;
        L)   #place window on left half of screen
            X=0
            W=$HALFSCREEN
            ;;
        FST)    # toggle fullscreen
            wmctrl -r :ACTIVE: -b toggle,maximized_vert,maximized_horz
            exit 1
            ;;
        *)
            exit 1
            ;;
    esac

    wmctrl -r :ACTIVE: -e 0,$X,0,$W,-1
    wmctrl -r :ACTIVE: -b add,maximized_vert
}

snap $1
