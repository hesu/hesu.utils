#!/bin/bash

##############################################################################

topdir='/home/hesu/proj/lua'
installdir='$(HESU_HOME)/lua/script/'

##############################################################################

echo "Start!!"

dirlist=(`find $topdir -type d -exec echo {} \;`)

for v in "${dirlist[@]}"; do
	touch $v/Jamfile
	
	# Make Jamfile!
	
	## SubDir TOP ...
	str_subdir_top=""
	
	subpath=${v:${#topdir}}

	subdirs=()
	IFS='/' read -ra subdirs <<< "$subpath"
	for d in "${subdirs[@]}"; do
		if [[ $d = *[!\ ]* ]]; then
			str_subdir_top="$str_subdir_top $d"
		fi
	done
#	str_subdir_top="$str_subdir_top ;"

	## LUA_SRCS ..
	str_lua_srcs="LUA_SRCS ="

	srclist=(`find ${v}/*.lua -type f -exec echo {} \;`)
	
	str_files=""
	for f in "${srclist[@]}"; do
		subfile=${f:${#v}+1}
		subfile=${subfile:0:${#subfile}-4}
		str_files="$str_files\t$subfile\n"
	done
	str_files="$str_files\t;"
	#echo -e $files

	## LUA COMPILE ..
	str_luac='Luac $(LUA_SRCS) ;'

	## INSTALL ..
	str_install_lua="InstallAbs ${installdir}${subpath} : \$(LUA_SRCS).lua ;"
	str_install_out="InstallAbs ${installdir}${subpath} : \$(LUA_SRCS).out ;"

	## SubInclude ..
	str_subinclude=""
	childdir=(`find ${v}/ -maxdepth 1 -type d -exec echo {} \;`)
	for sd in "${childdir[@]}"; do
		if [[ $sd = *[!\ ]* ]]; then
			subchilddir=${sd:${#v}+1}
			#echo $subchilddir
		
			if [[ $subchilddir = *[!\ ]* ]]; then
				str_subinclude="${str_subinclude}\nSubInclude TOP${str_subdir_top}"
				str_subinclude="$str_subinclude $subchilddir ;"
			fi
		fi
	done

	# Make Jamfile string
	jamstr="SubDir TOP${str_subdir_top} ;

${str_lua_srcs}
${str_files}
${str_luac}

${str_install_out}
${str_subinclude}"

	echo ""
	echo Generated $v/Jamfile :

	echo -e "${jamstr}" > $v/Jamfile
	#cat $v/Jamfile
done

echo "Done!"
