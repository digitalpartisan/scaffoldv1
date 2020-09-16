readonly MOD="mod"
readonly DEPENDENCIES="dependencies"
readonly GAME="game"
readonly PLUGIN_EXTENSIONS="plugin-extensions"
readonly GAME_PLUGIN_EXTENSIONS="game-plugin-extensions"
readonly GLOBAL_PLUGIN_EXTENSIONS="global-plugin-extensions"
readonly SYMLINK_LOCATIONS="symlink-locations"
readonly GAME_SYMLINK_LOCATIONS="game-symlink-locations"
readonly GLOBAL_SYMLINK_LOCATIONS="global-symlink-locations"
readonly ARCHIVE_EXTENSIONS="archive-extensions"
readonly GAME_ARCHIVE_EXTENSIONS="game-archive-extensions"
readonly GLOBAL_ARCHIVE_EXTENSIONS="global-archive-extensions"

readonly COMMANDS=( "$MOD" "$DEPENDENCIES" "$GAME" "$PLUGIN_EXTENSIONS" "$GAME_PLUGIN_EXTENSIONS" "$GLOBAL_PLUGIN_EXTENSIONS" "$SYMLINK_LOCATIONS"  "$GAME_SYMLINK_LOCATIONS" "$GLOBAL_SYMLINK_LOCATIONS" "$ARCHIVE_EXTENSIONS"  "$GAME_ARCHIVE_EXTENSIONS" "$GLOBAL_ARCHIVE_EXTENSIONS" )

case $2 in
	$MOD)
		source "$SCAFFOLD_PATH_CONFIG_MOD"
		printf "Mod name:\t\t%s\n" "$SCAFFOLD_MOD"
		printf "Game configuration:\t%s\n" "$SCAFFOLD_GAME"
		
		DEPENDENCY_LIST=$(scaffold config dependencies)
		if [[ -z "$DEPENDENCY_LIST" ]]
		then
			printf "Dependencies:\t\tN/A";
		else
			printf "Dependencies:\n"
			echo "$DEPENDENCY_LIST" | while read DEPENDENCY
			do
				printf "\t%s\n" "$DEPENDENCY"
			done
		fi
		;;
	$DEPENDENCIES)
		source "$SCAFFOLD_PATH_CONFIG_MOD"
		
		if [[ ! -z "$SCAFFOLD_TEMP_CONFIG_DEPENDENCIES" ]]
		then
			echo "$SCAFFOLD_TEMP_CONFIG_DEPENDENCIES" | tr "," "\n" | uniq
		fi
		;;
	$GLOBAL_PLUGIN_EXTENSIONS)
		if [[ -r "$SCAFFOLD_PATH_CONFIG_GLOBAL_PLUGINEXTENSIONS" ]]
		then
			cat "$SCAFFOLD_PATH_CONFIG_GLOBAL_PLUGINEXTENSIONS" | dos2unix | grep -v "^[[:space:]]*$" | uniq | sort
		fi
		;;
	$GAME_PLUGIN_EXTENSIONS)
		source "$SCAFFOLD_PATH_CONFIG_MOD"
		source "$SCAFFOLD_PATH_CONFIG_GAME"
		
		if [[ -r "$SCAFFOLD_PATH_GAME_PLUGINEXTENSIONS" ]]
		then
			cat "$SCAFFOLD_PATH_GAME_PLUGINEXTENSIONS" | dos2unix | grep -v "^[[:space:]]*$" | uniq | sort
		fi
		;;
	$PLUGIN_EXTENSIONS)
		{ scaffold config global-plugin-extensions ; scaffold config game-plugin-extensions ; } | cat | uniq | sort | tr '[:upper:]' '[:lower:]'
		;;
	$GLOBAL_SYMLINK_LOCATIONS)
		if [[ -r "$SCAFFOLD_PATH_CONFIG_GLOBAL_SYMLINKLOCATIONS" ]]
		then
			cat "$SCAFFOLD_PATH_CONFIG_GLOBAL_SYMLINKLOCATIONS" | dos2unix | grep -v "^[[:space:]]*$" | uniq | sort
		fi
		;;
	$GAME_SYMLINK_LOCATIONS)
		source "$SCAFFOLD_PATH_CONFIG_MOD"
		source "$SCAFFOLD_PATH_CONFIG_GAME"
		
		if [[ -r "$SCAFFOLD_PATH_GAME_SYMLINKLOCATIONS" ]]
		then
			cat "$SCAFFOLD_PATH_GAME_SYMLINKLOCATIONS" | dos2unix | grep -v "^[[:space:]]*$" | uniq | sort
		fi
		;;
	$SYMLINK_LOCATIONS)
		{ scaffold config global-symlink-locations ; scaffold config game-symlink-locations ; } | cat | uniq | sort
		;;
	$GAME_ARCHIVE_EXTENSIONS)
		source "$SCAFFOLD_PATH_CONFIG_MOD"
		source "$SCAFFOLD_PATH_CONFIG_GAME"
		
		if [[ -r "$SCAFFOLD_PATH_GAME_ARCHIVEEXTENSIONS" ]]
		then
			cat "$SCAFFOLD_PATH_GAME_ARCHIVEEXTENSIONS" | dos2unix | grep -v "^[[:space:]]*$" | uniq | sort
		fi
		;;
	$GLOBAL_ARCHIVE_EXTENSIONS)
		if [[ -r "$SCAFFOLD_PATH_CONFIG_GLOBAL_ARCHIVEEXTENSIONS" ]]
		then
			cat "$SCAFFOLD_PATH_CONFIG_GLOBAL_ARCHIVEEXTENSIONS" | dos2unix | grep -v "^[[:space:]]*$" | uniq | sort | tr '[:upper:]' '[:lower:]'
		fi
		;;
	$ARCHIVE_EXTENSIONS)
		{ scaffold config global-archive-extensions ; scaffold config game-archive-extensions ; } | cat | uniq | sort
		;;
	$GAME)
		source "$SCAFFOLD_PATH_CONFIG_MOD"
		source "$SCAFFOLD_PATH_CONFIG_GAME"
		readonly LINE_FORMAT="%-40s%s\n"
		
		printf "Game:\t\t\t%s\n" "$SCAFFOLD_GAME_NAME"
		printf "Plugin extension:\t%s\n" "$SCAFFOLD_GAME_ARCHIVE_EXTENSION"
		printf "Location:\t\t%s\n" "$SCAFFOLD_PATH_GAME_DATA"
		printf "$LINE_FORMAT" Directory Status
		printf "\n"
		
		scaffold config symlink-locations | while read LOCATION
		do
			PATH="$SCAFFOLD_PATH_GAME_DATA/$LOCATION"
			if [[ -d "$PATH" ]]
			then
				printf "%-40s%s\n" "$LOCATION" Ready
			else
				printf "%-40s%s\n" "$LOCATION" "Not Ready"
			fi
		done
		;;
	*)
	
	echo "Valid configuration types are: ${COMMANDS[@]}" >&2
	exit 1
esac
