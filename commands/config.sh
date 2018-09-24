readonly MOD="mod"
readonly DEPENDENCIES="dependencies"
readonly PACKAGE_EXTENSIONS="packageextensions"
readonly SYMLINK_LOCATIONS="symlinklocations"
readonly GAME="game"

case $2 in
	$MOD)
		source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"
		
		printf "Mod name:\t\t%s\n" "$SCAFFOLD_MOD_NAME"
		
		printf "Game path:\t\t%s\n" "$SCAFFOLD_MOD_GAME_PATH"
		
		printf "Game Data path:\t\t%s\n" "$SCAFFOLD_MOD_GAME_PATH_DATA"
		
		printf "Dependencies:\n"
		scaffold config dependencies| while read DEPENDENCY
		do
			printf "\t\t\t%s\n" "$DEPENDENCY"
		done
		;;
	$DEPENDENCIES)
		if [[ -r  "${SCAFFOLD_MOD_PATH_FILE_DEPENDENCIES}" ]]
		then
			cat "${SCAFFOLD_MOD_PATH_FILE_DEPENDENCIES}" | dos2unix | grep -v "^[[:space:]]*$" | uniq
		fi
		;;
	$PACKAGE_EXTENSIONS)
		cat "${SCAFFOLD_CONFIG_PATH_PACKAGE_EXTENSIONS}" | dos2unix | grep -v "^[[:space:]]*$" | uniq |tr [[:upper:]] [[:lower:]]
		;;
	$SYMLINK_LOCATIONS)
		cat "${SCAFFOLD_CONFIG_PATH_SYMLINK_LOCATIONS}" | dos2unix | grep -v "^[[:space:]]*$" | uniq
		;;
	$GAME)
		source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"
		
		printf "Searching in game location:\t%s\n\n" "$SCAFFOLD_MOD_GAME_PATH_DATA"
		printf "Directory:\t\t\tStatus:\n"
		
		scaffold config symlinklocations | while read LOCATION
		do
			PATH="${SCAFFOLD_MOD_GAME_PATH_DATA}/${LOCATION}"
			if [[ -d "${PATH}" ]]
			then
				printf "%s\t\t\t%s\n" "${LOCATION}" "Ready"
			else
				printf "%s\t\t\t%s\n" "${LOCATION}" "Not Ready"
			fi
		done
		;;
	*)
	
	echo "Valid configuration types are ${MOD}, ${DEPENDENCIES}, ${PACKAGE_EXTENSIONS}, ${SYMLINK_LOCATIONS}, and ${GAME}" >&2
	exit 1
esac
