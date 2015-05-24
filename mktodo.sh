#!/bin/sh
ls usr.bin/ obj/bsdtools/_install/usr/bin/ | xargs -n 1 | sort  | uniq -u | grep -v : | grep -v TODO >usr.bin/TODO
ls bin/ obj/bsdtools/_install/bin/ | xargs -n 1 | sort  | uniq -u | grep -v : | grep -v TODO >bin/TODO 
