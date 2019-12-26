readonly SCAFFOLD_PATH_GAME="$SCAFFOLD_PATH_CONFIG_GAMES/$SCAFFOLD_GAME"

if [[ ! -d "$SCAFFOLD_PATH_GAME" ]]
then
	echo "No game configuration exists, aborting operation" >&2
	exit 1
fi

readonly SCAFFOLD_PATH_GAME_CONFIG="$SCAFFOLD_PATH_GAME/$SCAFFOLD_NAME_FILE_CONFIG"

if [[ ! -r "$SCAFFOLD_PATH_GAME_CONFIG" ]]
then
	echo "Game config file not found, aborting operation" >&2
	exit 1
fi

source "$SCAFFOLD_PATH_GAME_CONFIG"

if [[ -z "$SCAFFOLD_GAME_NAME" || -z "$SCAFFOLD_GAME_PATH" || -z "$SCAFFOLD_GAME_ARCHIVE_EXTENSION" || -z "$SCAFFOLD_GAME_DELIVERABLE_PATH" ]]
then
	echo "Game configuration appears invalid, aborting operation" >&2
	exit 1
fi

if [[ ! -d "$SCAFFOLD_GAME_PATH" ]]
then
	echo "Game location appears invalid, aborting operation" >&2
	exit 1
fi

if [[ ! -d "$SCAFFOLD_GAME_DELIVERABLE_PATH" ]]
then
	echo "Game deliverable path appears invalid, aborting procedure" >&2
	exit 1
fi

readonly SCAFFOLD_PATH_GAME_DATA="$SCAFFOLD_GAME_PATH/$SCAFFOLD_NAME_DIRECTORY_DATA"

if [[ ! -d "$SCAFFOLD_PATH_GAME_DATA" ]]
then
	echo "Game data path appears invalid, aborting procedure" >&2
	exit 1
fi

readonly SCAFFOLD_PATH_GAME_ARCHIVEEXTENSIONS="$SCAFFOLD_PATH_GAME/$SCAFFOLD_NAME_FILE_ARCHIVEEXTENSIONS"
readonly SCAFFOLD_PATH_GAME_SYMLINKLOCATIONS="$SCAFFOLD_PATH_GAME/$SCAFFOLD_NAME_FILE_SYMLINKLOCATIONS"
readonly SCAFFOLD_PATH_GAME_PLUGINEXTENSIONS="$SCAFFOLD_PATH_GAME/$SCAFFOLD_NAME_FILE_PLUGINEXTENSIONS"
