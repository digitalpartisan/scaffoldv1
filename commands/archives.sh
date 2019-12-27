source "$SCAFFOLD_PATH_CONFIG_MOD"
source "$SCAFFOLD_PATH_CONFIG_GAME"

echo "$SCAFFOLD_GAME_ARCHIVE_EXTENSION" | scaffold util capitalization-variants | while read EXTENSION
do
	find "$SCAFFOLD_PATH_MOD_DATA" -type f -name "$SCAFFOLD_MOD*.$EXTENSION" | scaffold util remove-mod-data-path
done
