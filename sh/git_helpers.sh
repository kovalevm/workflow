function pullAllSubDirs() {
	for d in */ ; do
		cd "$d"
		echo -ne "\e[42m $d \e[0m branch - "
		git branch | grep \*
		echo -ne ""
		
		git pull
		
		cd .. 
	done
}

function clearBrachesInAllSubDirs() {
	for d in */ ; do
		cd "$d"

		echo -e "\e[42m $d \e[0m"

		deleteBranchesByPattenr $1

		cd ..	
	done
}

function deleteBranchesByPattenr() {
	if [ "$1" ]; then 
		if [ "$(git branch | grep $1.*)" ]; then
			git branch -d `git branch | grep "$1.*"`;
		else
			echo 'There are no branches :)';
		fi
	else
		echo 'Enter pattern!'
	fi
}
