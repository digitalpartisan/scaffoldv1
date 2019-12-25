source "$SCAFFOLD_PATH_CONFIG_MOD"

scaffold config archive-extensions | while read EXTENSION
do
	find "$SCAFFOLD_PATH_MOD_DATA" -type f -name "$SCAFFOLD_MOD*.$EXTENSION" | scaffold util remove-mod-data-path
done
