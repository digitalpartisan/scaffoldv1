source "$SCAFFOLD_PATH_CONFIG_MOD"

if [[ -z $2 ]]
then
	readonly GIVEN_MOD_NAME="$SCAFFOLD_MOD"
else
	readonly GIVEN_MOD_NAME=$2
fi

if [[ "$SCAFFOLD_MOD" == "$GIVEN_MOD_NAME" ]]
then
	readonly THISMOD=""
else
	readonly THISMOD=0
fi

readonly MOD_PATH="$SCAFFOLD_PATH_MODS/$GIVEN_MOD_NAME"
readonly DATA_PATH="$MOD_PATH/$SCAFFOLD_NAME_DIRECTORY_DATA"
readonly CONFIG_PATH="$MOD_PATH/$SCAFFOLD_NAME_CONFIG"
readonly EXCLUSION_FILE="$CONFIG_PATH/$SCAFFOLD_NAME_FILE_EXCLUSIONPATTERN"

scaffold config symlink-locations | while read MAP_DIRECTORY
do
	MAP_PATH="$DATA_PATH/$MAP_DIRECTORY"
	
	if [[ -d "$MAP_PATH" ]]
	then
		COMMAND="ls -1 \"$MAP_PATH\""
		if [[ "$MAP_DIRECTORY" == "$SCAFFOLD_DIRECTORY_SCRIPTS" ]]
		then
			COMMAND="$COMMAND | grep -v \"$SCAFFOLD_DIRECTORY_SOURCE\""
		fi
		if [[ -r "$EXCLUSION_FILE" && 0 == $THISMOD ]]
		then
			COMMAND="$COMMAND | grep -v --file=\"$EXCLUSION_FILE\""
		fi
		COMMAND="$COMMAND | scaffold util prepend-path \"$MAP_DIRECTORY\""
		
		eval "$COMMAND"
	fi
done

if [[ $THISMOD ]] 
then
	scaffold plugins
fi
