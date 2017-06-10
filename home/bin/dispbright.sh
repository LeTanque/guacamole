#!/bin/bash
# xrandr screen brightness adjust
display=LVDS1
printf '  dispbright\n' | toilet --gay -f smslant
echo "How bright would you like $display (input integer from 0.0 - 1.0)?"
read varpercent
#echo $varpercent
printf "Setting $display brightness to $varpercent\n"
xrandr --output $display --brightness $varpercent

