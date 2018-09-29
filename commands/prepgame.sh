source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"

scaffold config symlinklocations | while read LOCATION
do
	TARGET="$SCAFFOLD_MOD_GAME_PATH_DATA/$LOCATION"
	if [[ ! -d $TARGET ]] && ! mkdir "$TARGET"
	then
		echo "Game location not prepared, failed to create at least one symlink target location" >&2
		exit 1
	fi
done

echo "Game location prepared for development"
