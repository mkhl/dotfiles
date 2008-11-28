#!/bin/sh
#
####################################
# iTunes Command Line Control v1.0
# written by David Schlosnagle
# created 2001.11.08
####################################
# Modified by Bill Bumgarner
# <bbum@mac.com>
# 24-05-2008
#
# 1) updated to deal w/Leopard's sh
# 2) added ability to set rating
#    Ratings are 0-100
###################################

showHelp () {
    echo "-----------------------------";
    echo "iTunes Command Line Interface";
    echo "-----------------------------";
    echo "Usage: `basename $0` <option>";
    echo;
    echo "Options:";
    echo " status   = Shows iTunes' status, current artist and track.";
    echo " play     = Start playing iTunes.";
    echo " pause    = Pause iTunes.";
    echo " next     = Go to the next track.";
    echo " prev     = Go to the previous track.";
    echo " rate     = Set current track rating to # [0-100].";
    echo "            20-1 star, 40-2 stars, 60-3 stars, etc.";
    echo " mute     = Mute iTunes' volume.";
    echo " unmute   = Unmute iTunes' volume.";
    echo " vol up   = Increase iTunes' volume by 10%";
    echo " vol down = Increase iTunes' volume by 10%";
    echo " vol #    = Set iTunes' volume to # [0-100]";
    echo " stop     = Stop iTunes.";
    echo " quit     = Quit iTunes.";
}

if [ $# = 0 ]; then
    showHelp;
fi

while [ $# -gt 0 ]; do
    arg=$1;
    case $arg in
        "status" ) state=`osascript -e 'tell application "iTunes" to player state as string'`;
            echo "iTunes is currently $state.";
            if [ $state = "playing" ]; then
                artist=`osascript -e 'tell application "iTunes" to artist of current track as string'`;
                track=`osascript -e 'tell application "iTunes" to name of current track as string'`;
		rating=`osascript -e 'tell application "iTunes" to get rating of current track'`;
                echo "Current track $artist:  $track (Rating: $rating)";
            fi
            break ;;

        "play"    ) echo "Playing iTunes.";
            osascript -e 'tell application "iTunes" to play';
            break ;;

        "pause"    ) echo "Pausing iTunes.";
            osascript -e 'tell application "iTunes" to pause';
            break ;;

        "next"    ) echo "Going to next track." ;
            osascript -e 'tell application "iTunes" to next track';
            break ;;

        "prev"    ) echo "Going to previous track.";
            osascript -e 'tell application "iTunes" to previous track';
            break ;;

	"rate"    ) echo "Setting rating on current track.";
	    osascript -e "tell application \"iTunes\" to set rating of current track to $2";
	    break ;;

        "mute"    ) echo "Muting iTunes volume level.";
            osascript -e 'tell application "iTunes" to set mute to true';
            break ;;

        "unmute" ) echo "Unmuting iTunes volume level.";
            osascript -e 'tell application "iTunes" to set mute to false';
            break ;;

        "vol"    ) echo "Changing iTunes volume level.";
            vol=`osascript -e 'tell application "iTunes" to sound volume as integer'`;
            if [ $2 = "up" ]; then
                newvol=$(( vol+10 ));
            elif [ $2 = "down" ]; then
                newvol=$(( vol-10 ));
            elif [ $2 -gt 0 ]; then
                newvol=$2;
            fi
            osascript -e "tell application \"iTunes\" to set sound volume to $newvol";
            break ;;

        "stop"    ) echo "Stopping iTunes.";
            osascript -e 'tell application "iTunes" to stop';
            break ;;
            
        "quit"    ) echo "Quitting iTunes.";
            osascript -e 'tell application "iTunes" to quit';
            exit 1 ;;

        "help" | * ) echo "help:";
            showHelp;
            break ;;
    esac
done
