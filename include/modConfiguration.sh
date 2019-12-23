readonly SCAFFOLD_PATH_MOD=$(pwd)
readonly SCAFFOLD_PATH_MOD_CONFIG=$SCAFFOLD_PATH_MOD/$SCAFFOLD_NAME_DIRECTORY_CONFIG

if [[ ! -d $SCAFFOLD_PATH_MOD_CONFIG ]]
then
	echo "Mod configuration directory does not exist" >&2
	exit 1
fi

readonly SCAFFOLD_PATH_MOD_CONFIG_MAIN=$SCAFFOLD_PATH_MOD_CONFIG/$SCAFFOLD_NAME_FILE_CONFIG

if [[ -r $SCAFFOLD_PATH_MOD_CONFIG_MAIN ]]
then
	source "$SCAFFOLD_PATH_MOD_CONFIG_MAIN"
else
	echo "No mod configuration detected, aborting operation" >&2
	exit 1
fi

if [[ -z $SCAFFOLD_MOD || -z $SCAFFOLD_GAME ]]
then
	echo "Mod configuration appears incomplete, aborting specified operation" >&2
	exit 1
fi

readonly SCAFFOLD_PATH_MODS=$( dirname "$SCAFFOLD_PATH_MOD" )
readonly SCAFFOLD_PATH_MOD_CONFIG_DEPENDENCIES=$SCAFFOLD_PATH_MOD_CONFIG/$SCAFFOLD_NAME_FILE_DEPENDENCIES
