#!/bin/bash
for account in pobox umich; do
  /usr/local/bin/offlineimap -u basic -o -a ${account^}
done
