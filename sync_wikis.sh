#!/bin/bash

export PATH=/usr/local/bin:$PATH

LOG=~/tmp/gnsync.log
WIKI_DIR=$HOME/Dropbox/Wikis
WIKIS=(
  Default:Wiki
  Labbooks:Labbooks
  ConcertPharma:ConcertPharma
  SPH-ICS:SPH-ICS
  Biostat:Biostat
  Flux:Flux
)

for line in "${WIKIS[@]}"; do
  wiki=${line%:*}
  notebook=${line#*:}

  gnsync -p $WIKI_DIR/$wiki -f markdown -n "$notebook" -l $LOG
done
