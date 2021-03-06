#!/bin/bash

tempfile=$(tempfile 2>/dev/null) || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

while true; do
  dialog \
    --backtitle "SomaFM: Listener Supported, Commercial Free Internet Radio" \
    --title "Select a station to listen to" \
    --clear \
    --radiolist "Select a station to listen to" 20 60 24 \
      "deepspaceone"   "Deep Space One"         off \
      "groovesalad"    "Groove Salad"           off \
      "lush"           "Lush"                   off \
      "dronezone"      "Drone Zone"             off \
      "sonicuniverse"  "Sonic Universe"         off \
      "digitalis"      "Digitalis"              off \
      "indiepoprocks"  "indie pop rocks"        off \
      "poptron"        "PopTron"                off \
      "480min"         "480 Minutes"            off \
      "covers"         "Covers"                 off \
      "u80s"           "Underground 80s"        off \
      "secretagent"    "Secret Agent"           off \
      "suburbsofgoa"   "Suburbs of Goa"         off \
      "beatblender"    "Beat Blender"           off \
      "dubstep"        "Dub Step Beyond"        off \
      "cliqhop"        "cliqhop idm"            off \
      "spacestation"   "Space Station"          off \
      "missioncontrol" "Mission Control"        off \
      "bootliquor"     "Boot Liquor"            off \
      "illstreet"      "Illinois Street Lounge" off \
      "tags"           "Tags Trip"              off \
      "doomed"         "Doomed"                 off \
      "brfm"           "Black Rock FM"          off \
      "sxfm"           "South by Soma"          off \
      "sf1033"         "SF 10-33"               off \
      "xmasinfrisko"   "Xmas in Frisko"         off \
      "christmas"      "Christmas Lounge"       off \
      "xmasrocks"      "Christmas Rocks!"       off \
      "bagel"          "BAGel Radio"            off \
      "folkfwd"        "Fold Forward"           off 2> $tempfile

  test $? == 1 && exit
  station="$(cat $tempfile)"
  mplayer -quiet -vo none -ao sdl http://somafm.com/startstream=${station}.pls 2>&1 \
    | dialog --progressbox 20 60
done
