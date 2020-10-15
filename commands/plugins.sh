source "$SCAFFOLD_PATH_CONFIG_MOD"
source "$SCAFFOLD_PATH_CONFIG_GAME"

scaffold config plugin-extensions | while read PLUGIN_EXTENSION
do
	if [[ $RELEASING ]]
	then
		FILENAME="$SCAFFOLD_MOD.$PLUGIN_EXTENSION"
		if [[ -f "$SCAFFOLD_PATH_MOD_DATA/$FILENAME" ]]
		then
			echo "$FILENAME"
			exit 0
		fi
	else
		find "$SCAFFOLD_PATH_MOD_DATA" -type f -name "*.$PLUGIN_EXTENSION" | scaffold util remove-mod-data-path
	fi
done
