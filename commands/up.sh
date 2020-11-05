source "$SCAFFOLD_PATH_CONFIG_MOD"
source "$SCAFFOLD_PATH_CONFIG_GAME"

function upDependency() {
	if [[ -z $1 ]]
	then
		return
	fi
	
	MOD_PATH="$SCAFFOLD_PATH_MODS/$1"
	cd "$MOD_PATH"
	echo "`date +%H:%M:%S` - Upping $1"
	scaffold up
	cd "$SCAFFOLD_PATH_MOD"
}

if [[ $RELEASING ]]
then
	scaffold archives | scaffold map
	scaffold plugins --release | scaffold map
else
	if [[ $DEPENDENCIES ]]
	then
		echo "Upping dependencies"
		{ scaffold config exhaustive-dependencies; echo "$SCAFFOLD_MOD"; } | while read DEPENDENCY
		do
			upDependency "$DEPENDENCY"
		done

		echo "`date +%H:%M:%S` - Done"
	else
		scaffold symlink-locations | scaffold map
		scaffold plugins | scaffold map
	fi
fi
