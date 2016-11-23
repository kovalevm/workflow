# $1 - command, $2 - folder, $3 arg for command
function execInFolderOrHere() {
	if [ "$2" ]; then
		PWDD=`pwd`;
		
		cd $2 
		
		if [ "$3" ]; then
			$1 $3
		else
			$1
		fi

		cd $PWDD;
	else
		if [ "$3" ]; then
			$1 $3
		else
			$1
		fi	
	fi
}

# $1 - command
function execInAllSubDirs() {
	for d in */ ; do

		echo -e "\e[42m $d \e[0m"
		
		cd "$d"
		
		$1
		
		cd .. 

	done
}
