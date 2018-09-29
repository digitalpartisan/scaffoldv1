function findModLooseFiles() {
	if [[ -z $1 ]]
	then
		return
	fi
	
	if [[ $SCAFFOLD_MOD_NAME == $1 ]]
	then
		EXCLUDE=0
	else
		EXCLUDE=1
	fi
	
	MOD_PATH="$SCAFFOLD_MODS_LOCATION/$1"
	DATA_PATH="$MOD_PATH/$SCAFFOLD_MOD_DIRECTORY_DATA"
	EXCLUSION_FILE="$MOD_PATH/$SCAFFOLD_MOD_RELATIVE_PATH_PACKAGE_EXCLUSIONS"
	
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
			if [[ -r $EXCLUSION_FILE && 1 == $EXCLUDE ]]
			then
				COMMAND="$COMMAND | grep -v --file=\"$EXCLUSION_FILE\""
			fi
			COMMAND="$COMMAND | scaffold util prependpath \"$MAP_DIRECTORY\""
			
			eval "$COMMAND"
		fi
	done
}

source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"

scaffold config dependencies | while read DEPENDENCY
do
	findModLooseFiles "$DEPENDENCY"
done

findModLooseFiles "$SCAFFOLD_MOD_NAME"
