readonly SCRIPTS="Scripts"
readonly SOURCE="Source"

source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"

scaffold config symlinklocations | while read MAP_DIRECTORY
do
	MAP_PATH="${SCAFFOLD_MOD_PATH_DATA}/${MAP_DIRECTORY}"
	PATH_PREFIX=$( echo "${MAP_DIRECTORY}/" | sed 's/\//\\\//g' | sed 's/\ /\\\ /g')
	
	if [[ -d "$MAP_PATH" ]]
	then
		if [[ $MAP_DIRECTORY == $SCRIPTS ]]
		then
			ls -1 "$MAP_PATH" | grep -v "${SOURCE}" | sed "s/^/$PATH_PREFIX/g"
		else
			ls -1 "$MAP_PATH" | sed "s/^/$PATH_PREFIX/g"
		fi
	fi
done
