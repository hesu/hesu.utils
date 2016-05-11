#!/bin/bash

#########################################################################################################
bkupdirs=(
	"/home/hesu/myproj/lua"
)

bkupfiles=(
	"/home/hesu/myproj/process.conf"
)

staticpath="/home/hesu/dailybak/"


#########################################################################################################

todaytimepath=$(date +"%m/%d/%H/%M")
#echo $todaytimepath
#echo $staticpath

mkdir -p $staticpath$todaytimepath

echo "[ directory copy start! ]"
for v in "${bkupdirs[@]}"; do
	cp -rf $v $staticpath$todaytimepath
	echo "copy $v to                   $staticpath$todaytimepath"
done

echo ""
echo "[ file copy start! ]"
for v in "${bkupfiles[@]}"; do
	cp -f $v $staticpath$todaytimepath
	echo "copy $v to                       $staticpath$todaytimepath"
done

echo ""
echo "[ Remove swp, core, (TODO)logs ]"
#for v in "${bkupfiles[@]}"; do
for v in "${bkupdirs[@]}"; do
#find . -name "*.swp" $staticpath$todaytimepath -ls # notwork; cannot see that in shell!!!
	find $staticpath$todaytimepath -name "*.swp" -ls
	find $staticpath$todaytimepath -name "*.swp" -exec rm {} \;
	find $staticpath$todaytimepath -name "core.*" -ls
	find $staticpath$todaytimepath  -name "core.*" -exec rm {} \;
done
echo ""
echo "done."
