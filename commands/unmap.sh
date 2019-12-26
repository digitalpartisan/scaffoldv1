source "$SCAFFOLD_PATH_CONFIG_MOD"
source "$SCAFFOLD_PATH_CONFIG_GAME"

EXIT_RESULT=0

while read TARGET
do
	TARGET_PATH="$SCAFFOLD_PATH_MOD_DATA/$TARGET"
	LINK_PATH="$SCAFFOLD_PATH_GAME_DATA/$TARGET"
	
	if [[ -f "$LINK_PATH" || -d "$LINK_PATH" ]]
	then
		if [[ -f "$TARGET_PATH" ]] && ! [[ "$LINK_PATH" -ef "$TARGET_PATH" ]]
		then
			cp -f "$LINK_PATH" "$TARGET_PATH"
		fi
		
		unlink "$LINK_PATH"
	fi
done
