source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"
source "$SCAFFOLD_CONFIG_PATH_INCLUDE_GAME_CONFIGURATION"

EXIT_RESULT=0

while read TARGET
do
	TARGET_PATH="$SCAFFOLD_MOD_PATH_DATA/$TARGET"
	LINK_PATH="$SCAFFOLD_MOD_GAME_PATH_DATA/$TARGET"
	
	CMD_TARGET_PATH=$( echo "$TARGET_PATH" | scaffold util getwindowspath )
	CMD_LINK_PATH=$( echo "$LINK_PATH" | scaffold util getwindowspath )
	
	COMMAND=""
	
	if [[ ! -f $LINK_PATH && ! -d $LINK_PATH ]]
	then
		if [[ -f $TARGET_PATH ]]
		then
			COMMAND="mklink /H \"$CMD_LINK_PATH\" \"$CMD_TARGET_PATH\""
		elif [[ -d $TARGET_PATH ]]
		then
			COMMAND="mklink /J \"$CMD_LINK_PATH\" \"$CMD_TARGET_PATH\""
		else
			echo "The specified map target \"$TARGET\" does not exist in this mod" >&2
			EXIT_RESULT=1
		fi
		
		if [[ ! -z $COMMAND ]]
		then
			cmd <<< "$COMMAND" > /dev/null
		fi
	fi
done

exit $EXIT_RESULT
