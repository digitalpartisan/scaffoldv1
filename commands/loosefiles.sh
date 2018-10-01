source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"

if [[ -z $2 ]]
then
	readonly GIVEN_MOD_NAME=$SCAFFOLD_MOD_NAME
else
	readonly GIVEN_MOD_NAME=$2
fi

if [[ $SCAFFOLD_MOD_NAME == $GIVEN_MOD_NAME ]]
then
	readonly THISMOD=1
else
	readonly THISMOD=0
fi

readonly MOD_PATH="$SCAFFOLD_MODS_LOCATION/$GIVEN_MOD_NAME"
readonly DATA_PATH="$MOD_PATH/$SCAFFOLD_MOD_DIRECTORY_DATA"
readonly EXCLUSION_FILE="$MOD_PATH/$SCAFFOLD_MOD_RELATIVE_PATH_EXCLUSION_FILE"

scaffold config symlinklocations | while read MAP_DIRECTORY
do
	MAP_PATH="$DATA_PATH/$MAP_DIRECTORY"
	
	if [[ -d $MAP_PATH ]]
	then
		COMMAND="ls -1 \"$MAP_PATH\""
		if [[ $MAP_DIRECTORY == $SCAFFOLD_DIRECTORY_SCRIPTS ]]
		then
			COMMAND="$COMMAND | grep -v \"$SCAFFOLD_DIRECTORY_SOURCE\""
		fi
		if [[ -r $EXCLUSION_FILE && 0 == $THISMOD ]]
		then
			COMMAND="$COMMAND | grep -v --file=\"$EXCLUSION_FILE\""
		fi
		COMMAND="$COMMAND | scaffold util prependpath \"$MAP_DIRECTORY\""
		
		eval "$COMMAND"
	fi
done

if [[ 1 == $THISMOD ]] 
then
	scaffold plugins
fi
