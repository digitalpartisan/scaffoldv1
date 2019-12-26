source "$SCAFFOLD_PATH_CONFIG_MOD"

scaffold config symlink-locations | while read MAP_DIRECTORY
do
	MAP_PATH="$SCAFFOLD_PATH_MOD_DATA/$MAP_DIRECTORY"
	
	if [[ -d "$MAP_PATH" ]]
	then
		COMMAND="ls -1 \"$MAP_PATH\""
		if [[ "$MAP_DIRECTORY" == "$SCAFFOLD_DIRECTORY_SCRIPTS" ]]
		then
			COMMAND="$COMMAND | grep -v \"$SCAFFOLD_DIRECTORY_SOURCE\""
		fi
		
		if [[ "$MAP_DIRECTORY" == "$SCAFFOLD_DIRECTORY_MESHES" ]]
		then
			COMMAND="$COMMAND | grep -v \"$SCAFFOLD_DIRECTORY_PRECOMBINED\""
		fi
		
		COMMAND="$COMMAND | scaffold util prepend-path \"$MAP_DIRECTORY\""
		
		eval "$COMMAND"
	fi
done
