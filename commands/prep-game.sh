source "$SCAFFOLD_PATH_CONFIG_MOD"
source "$SCAFFOLD_PATH_CONFIG_GAME"

scaffold config symlink-locations | while read LOCATION
do
	TARGET="$SCAFFOLD_PATH_GAME_DATA/$LOCATION"
	if [[ ! -d "$TARGET" ]] && ! mkdir "$TARGET"
	then
		echo "Game location not prepared, failed to create at least one symlink target location" >&2
		exit 1
	fi
done

echo "Game location prepared for development"
