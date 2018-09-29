source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"

scaffold config symlinklocations | while read MAP_DIRECTORY
do
	MAP_PATH="$SCAFFOLD_MOD_PATH_DATA/$MAP_DIRECTORY"
	
	if [[ -d $MAP_PATH ]]
	then
		COMMAND="ls -1 \"$MAP_PATH\""
		if [[ $MAP_DIRECTORY == $SCAFFOLD_DIRECTORY_SCRIPTS ]]
		then
			COMMAND="$COMMAND | grep -v \"$SCAFFOLD_DIRECTORY_SOURCE\""
		fi
		COMMAND="$COMMAND | scaffold util prependpath \"$MAP_DIRECTORY\""
		
		eval $COMMAND
	fi
done
