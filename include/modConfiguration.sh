if [[ -r $SCAFFOLD_MOD_PATH_CONFIG_FILE ]]
then
	source "$SCAFFOLD_MOD_PATH_CONFIG_FILE"
else
	echo "No mod configuration detected, aborting operation" >&2
	exit 1
fi

if [[ -z $SCAFFOLD_MOD_NAME || -z $SCAFFOLD_MOD_GAME_PATH ]]
then
	echo "Mod configuration appears incomplete, aborting specified operation" >&2
	exit 1
fi

readonly SCAFFOLD_MOD_GAME_PATH_DATA=$SCAFFOLD_MOD_GAME_PATH/$SCAFFOLD_MOD_DIRECTORY_DATA
if [[ ! -d "$SCAFFOLD_MOD_GAME_PATH_DATA" ]]
then
	echo "Mod configuration appears invalid, cannot locate game's data directory" >&2
	exit 1
fi

readonly SCAFFOLD_MODS_LOCATION=$( dirname "$SCAFFOLD_MOD_PATH" )
