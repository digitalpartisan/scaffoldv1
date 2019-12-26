readonly SCAFFOLD_PATH_CONFIG="$HOME/$SCAFFOLD_NAME_DIRECTORY_CONFIG"

if [[ ! -d "$SCAFFOLD_PATH_CONFIG" ]]
then
	echo "Environmental configuration directory does not exist, aborting operation" >&2
	exit 1
fi

readonly SCAFFOLD_PATH_CONFIG_GAMES="$SCAFFOLD_PATH_CONFIG/$SCAFFOLD_NAME_DIRECTORY_GAMES"

if [[ ! -d "$SCAFFOLD_PATH_CONFIG_GAMES" ]]
then
	echo "Games configuration directory does not exist, aborting operation" >&2
	exit 1
fi

readonly SCAFFOLD_PATH_CONFIG_GLOBAL="$SCAFFOLD_PATH_CONFIG/$SCAFFOLD_NAME_DIRECTORY_GLOBAL"
readonly SCAFFOLD_PATH_CONFIG_GLOBAL_SYMLINKLOCATIONS="$SCAFFOLD_PATH_CONFIG_GLOBAL/$SCAFFOLD_NAME_FILE_SYMLINKLOCATIONS"
readonly SCAFFOLD_PATH_CONFIG_GLOBAL_PLUGINEXTENSIONS="$SCAFFOLD_PATH_CONFIG_GLOBAL/$SCAFFOLD_NAME_FILE_PLUGINEXTENSIONS"
readonly SCAFFOLD_PATH_CONFIG_GLOBAL_ARCHIVEEXTENSIONS="$SCAFFOLD_PATH_CONFIG_GLOBAL/$SCAFFOLD_NAME_FILE_ARCHIVEEXTENSIONS"
