source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"

for PLUGIN_EXTENSION in "${SCAFFOLD_MOD_EXTENSIONS_PLUGIN[@]}"
do
	if [[ $RELEASING == 1 ]]
	then
		FILENAME="$SCAFFOLD_MOD_NAME.$PLUGIN_EXTENSION"
		if [[ -f "$SCAFFOLD_MOD_PATH_DATA/$FILENAME" ]]
		then
			echo $FILENAME
			exit 0
		fi
	else
		find "$SCAFFOLD_MOD_PATH_DATA" -type f -name "*.$PLUGIN_EXTENSION" | scaffold util removemoddatapath
	fi
done
