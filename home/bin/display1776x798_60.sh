#!/bin/bash
# display mode modification
# cvt -> xrandr -> xrandr
#####################################################
RESO='1360 768 60'
DEV='LVDS1'	# The device could be LVDS1, VGA1, HDMI1, or DP1, for instance.

MODE="cvt $RESO"
GRAB="grep $ML"
ML='Modeline '
#MODE2={$MODE | grep -o "....x..._....."}
#MODE3='\$\MODE2 | grep -oi "Modeline "'
MODELINE='"1776x798_60.00"  115.25  1776 1864 2048 2320  798 801 811 829 -hsync +vsync'

#if {
#	cvt $RESO | grep -oi "Modeline "
#	then
#	output=MODE2
#fi 
#}
#####################################################

#printf 'display' | figlet -xf smblock
#printf "> $MODE \n $DEV \n"
#$MODE
echo
cvt 1360 768 60 | grep $ML
xrandr | cut -c "V" -f 1 -
$GMODE
#printf '> $MODE2\n'
#$MODE2 | grep -o "....x..._....."
#$MODE3
#xrandr --newmode $MODE3
#xrandr --newmode $MODELINE
#xrandr --addmode $DEV $MODE
exit $?