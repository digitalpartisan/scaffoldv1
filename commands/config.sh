readonly MOD="mod"
readonly DEPENDENCIES="dependencies"
readonly PACKAGE_EXTENSIONS="packageextensions"
readonly SYMLINK_LOCATIONS="symlinklocations"
readonly GAME="game"

readonly COMMANDS=( "$MOD" "$DEPENDENCIES" "$PACKAGE_EXTENSIONS" "$SYMLINK_LOCATIONS" "$GAME")

case $2 in
	$MOD)
		source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"
		
		printf "Mod name:\t\t%s\n\n" "$SCAFFOLD_MOD_NAME"
		
		printf "Game path:\t\t%s\n" "$SCAFFOLD_MOD_GAME_PATH"
		
		printf "Game Data path:\t\t%s\n\n" "$SCAFFOLD_MOD_GAME_PATH_DATA"
		
		printf "Dependencies:\n"
		scaffold config dependencies| while read DEPENDENCY
		do
			printf "\t\t\t%s\n" "$DEPENDENCY"
		done
		;;
	$DEPENDENCIES)
		source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"
		
		if [[ ! -z  $SCAFFOLD_MOD_DEPENDENCIES ]]
		then
			echo "$SCAFFOLD_MOD_DEPENDENCIES" | tr "," "\n" | dos2unix | grep -v "^[[:space:]]*$"
		fi
		;;
	$PACKAGE_EXTENSIONS)
		cat "$SCAFFOLD_CONFIG_PATH_PACKAGE_EXTENSIONS" | dos2unix | sort | uniq | grep -v "^[[:space:]]*$" | tr [[:upper:]] [[:lower:]]
		;;
	$SYMLINK_LOCATIONS)
		cat "$SCAFFOLD_CONFIG_PATH_SYMLINK_LOCATIONS" | dos2unix | sort | uniq | grep -v "^[[:space:]]*$"
		;;
	$GAME)
		source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"
		
		readonly LINE_FORMAT="%-40s%s\n"
		
		printf "Game location:\t%s\n\n" "$SCAFFOLD_MOD_GAME_PATH_DATA"
		printf "$LINE_FORMAT" Directory Status
		printf "\n"
		
		scaffold config symlinklocations | while read LOCATION
		do
			PATH="$SCAFFOLD_MOD_GAME_PATH_DATA/$LOCATION"
			if [[ -d $PATH ]]
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
