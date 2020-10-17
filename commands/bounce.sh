source "$SCAFFOLD_PATH_CONFIG_MOD"
source "$SCAFFOLD_PATH_CONFIG_GAME"

function bounceDependency() {
	if [[ -z $1 ]]
	then
		return
	fi
	
	MOD_PATH="$SCAFFOLD_PATH_MODS/$1"
	cd "$MOD_PATH"
	echo "`date +%H:%M:%S` - Bouncing $1"
	scaffold bounce
	cd "$SCAFFOLD_PATH_MOD"
}

if [[ $DEPENDENCIES ]]
then
	echo "Bouncing dependencies"
	scaffold config dependencies | while read DEPENDENCY
	do
		bounceDependency "$DEPENDENCY"
	done

	bounceDependency "$SCAFFOLD_MOD"

	echo "`date +%H:%M:%S` - Done"
else
	scaffold down && scaffold up
fi
