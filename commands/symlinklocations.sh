readonly SCRIPTS="Scripts"
readonly SOURCE="Source"

source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"

scaffold config symlinklocations | while read MAP_DIRECTORY
do
	MAP_PATH="${SCAFFOLD_MOD_PATH_DATA}/${MAP_DIRECTORY}"
	
	if [[ -d "$MAP_PATH" ]]
	then
		if [[ $MAP_DIRECTORY == $SCRIPTS ]]
		then
			ls -1 "$MAP_PATH" | grep -v "${SOURCE}" | scaffold util prependpath "${MAP_DIRECTORY}"
		else
			ls -1 "$MAP_PATH" | scaffold util prependpath "${MAP_DIRECTORY}"
		fi
	fi
done
