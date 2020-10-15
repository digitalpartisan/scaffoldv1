source "$SCAFFOLD_PATH_CONFIG_MOD"

function buildPapyrus() {
	if [[ -z $1 ]]
	then
		return
	fi
	
	MOD_PATH="$SCAFFOLD_PATH_MODS/$1"
	PPJ_PATH=$( echo "$MOD_PATH/$PPJ_FILE" | scaffold util get-windows-path )
	
	COMMAND="$SCAFFOLD_PAPYRUS_COMPILER \"$PPJ_PATH\" -q"
	
	echo "`date +%H:%M:%S` - Compiling $1"
	cmd <<< "$COMMAND" 1>/dev/null
}

if [[ $RELEASING ]]
then
	echo "Compiling in release mode"
	readonly PPJ_FILE="$SCAFFOLD_PAPYRUS_FILE_BUILD_RELEASE"
else
	readonly PPJ_FILE="$SCAFFOLD_PAPYRUS_FILE_BUILD"
fi

if [[ $DEPENDENCIES ]]
then
	echo "Compiling dependencies"
	scaffold config dependencies | while read DEPENDENCY
	do
		buildPapyrus "$DEPENDENCY"
	done
fi

buildPapyrus "$SCAFFOLD_MOD"

echo "`date +%H:%M:%S` - Done"
