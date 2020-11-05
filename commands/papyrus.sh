source "$SCAFFOLD_PATH_CONFIG_MOD"
source "$SCAFFOLD_PATH_CONFIG_GAME"

function cleanPapyrus() {
	if [[ -z $1 ]]
	then
		return
	fi

	SOURCE_DIRECTORIES=$(echo "$SCAFFOLD_PATH_MODS/$1/$SCAFFOLD_NAME_DIRECTORY_DATA/$SCAFFOLD_DIRECTORY_SCRIPTS/*/" | sed -r 's/\s/\\ /g')
	CLEAN_COMMAND="find $SOURCE_DIRECTORIES -type f -name \"*.$SCAFFOLD_PATH_GAME_SCRIPTEXTENSION\" -exec rm {} \\;"
	eval $CLEAN_COMMAND
}

function buildPapyrus() {
	if [[ -z $1 ]]
	then
		return
	fi
	
	MOD_PATH="$SCAFFOLD_PATH_MODS/$1"
	PPJ_PATH=$( echo "$MOD_PATH/$PPJ_FILE" | scaffold util get-windows-path )
	
	BUILD_COMMAND="$SCAFFOLD_PAPYRUS_COMPILER \"$PPJ_PATH\" -q"
	
	echo "`date +%H:%M:%S` - Compiling $1"

	if [[ $CLEANING ]]
	then
		cleanPapyrus $1
	fi

	cmd <<< "$BUILD_COMMAND" 1>/dev/null
}

if [[ $CLEANING ]]
then
	echo "Cleaning old compilation results"
fi

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
	scaffold config exhaustive-dependencies | while read DEPENDENCY
	do
		buildPapyrus "$DEPENDENCY"
	done
fi

buildPapyrus "$SCAFFOLD_MOD"

echo "`date +%H:%M:%S` - Done"
