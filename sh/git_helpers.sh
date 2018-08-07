function pullAllSubDirs() {
	bold=$(tput bold)
	normal=$(tput sgr0)
	for d in */ ; do
		cd "$d"
		echo -ne "${bold}${d}${normal} branch - "
		git branch | grep \*
		echo -ne ""
		
		git pull
		
		cd .. 
	done
}

function clearBrachesInAllSubDirs() {
	bold=$(tput bold)
	normal=$(tput sgr0)
	for d in */ ; do
		cd "$d"

		echo -e "${bold}${d}${normal}"

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

function setHooks() {
	for d in */ ; do
		echo -e "\e[42m $d \e[0m"

		cd "$d"

		read -p "Replace hooks in? " -n 1 -r
		echo    # (optional) move to a new line
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
		    ln -sf /home/local/opt/zz_customs/git-hooks/hooks/prepare-commit-msg  .git/hooks/
		fi

		read -p "Replace hooks in subdirs? " -n 1 -r
		echo    # (optional) move to a new line
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
		    for ds in */ ; do
		    	echo -e "    \e[42m $ds \e[0m"
		    	
		    	cd "$ds"
		    	
		    	ln -sf /home/local/opt/zz_customs/git-hooks/hooks/prepare-commit-msg  .git/hooks/
		    	
		    	cd .. 
		    done
		fi

		cd ..
	done
}
