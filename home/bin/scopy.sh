#!/bin/bash
# scp helper


files=[df -h | awk '${print 3}']

echo -n "Enter file to copy:  "
read filetocopy; echo $filetocopy >> $FSCP


