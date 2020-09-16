readonly SCAFFOLD_PATH_MOD="$(pwd)"
readonly SCAFFOLD_PATH_MOD_CONFIG="$SCAFFOLD_PATH_MOD/$SCAFFOLD_NAME_FILE_CONFIG"

if [[ -r "$SCAFFOLD_PATH_MOD_CONFIG" ]]
then
	source "$SCAFFOLD_PATH_MOD_CONFIG"
else
	echo "No mod configuration detected, aborting operation" >&2
	exit 1
fi

if [[ -z "$SCAFFOLD_TEMP_CONFIG_MOD" || -z "$SCAFFOLD_TEMP_CONFIG_GAME" ]]
then
	echo "Mod configuration appears incomplete, aborting specified operation" >&2
	exit 1
fi
readonly SCAFFOLD_MOD=$SCAFFOLD_TEMP_CONFIG_MOD
readonly SCAFFOLD_GAME=$SCAFFOLD_TEMP_CONFIG_GAME
readonly SCAFFOLD_MOD_DEPENDENCIES=$SCAFFOLD_TEMP_CONFIG_DEPENDENCIES

readonly SCAFFOLD_PATH_MOD_DATA="$SCAFFOLD_PATH_MOD/$SCAFFOLD_NAME_DIRECTORY_DATA"
if [[ ! -d "$SCAFFOLD_PATH_MOD_DATA" ]]
then
	echo "Mod data directory missing, aborting operation" >&2
fi

readonly SCAFFOLD_PATH_MOD_ACHLIST="$SCAFFOLD_PATH_MOD/$SCAFFOLD_NAME_FILE_ACHLIST"
readonly SCAFFOLD_PATH_MODS=$( dirname "$SCAFFOLD_PATH_MOD" )
