source "$SCAFFOLD_PATH_CONFIG_MOD"
source "$SCAFFOLD_PATH_CONFIG_GAME"

function downDependency() {
	if [[ -z $1 ]]
	then
		return
	fi
	
	MOD_PATH="$SCAFFOLD_PATH_MODS/$1"
	cd "$MOD_PATH"
	echo "`date +%H:%M:%S` - Downing $1"
	scaffold down
	cd "$SCAFFOLD_PATH_MOD"
}

if [[ $DEPENDENCIES ]]
then
	echo "Downing dependencies"
	scaffold config dependencies | while read DEPENDENCY
	do
		downDependency "$DEPENDENCY"
	done

	downDependency "$SCAFFOLD_MOD"

	echo "`date +%H:%M:%S` - Done"
else
	scaffold plugins | scaffold unmap
	scaffold archives | scaffold unmap
	scaffold symlink-locations | scaffold unmap
fi
