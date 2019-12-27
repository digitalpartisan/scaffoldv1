readonly GET_WINDOWS_PATH="get-windows-path"
readonly GET_ESCAPED_PATH="get-escaped-path"
readonly REMOVE_PATH="remove-path"
readonly REMOVE_MOD_PATH="remove-mod-path"
readonly REMOVE_MOD_DATA_PATH="remove-mod-data-path"
readonly FORMAT_FOR_ACHLIST="format-for-achlist"
readonly PREPEND_PATH="prepend-path"
readonly DELIVER="deliver"
readonly CAPITALIZATION_VARIANTS="capitalization-variants"

readonly COMMANDS=( "$GET_WINDOWS_PATH" "$GET_ESCAPED_PATH" "$REMOVE_PATH" "$REMOVE_MOD_PATH" "$REMOVE_MOD_DATA_PATH" "$FORMAT_FOR_ACHLIST" "$PREPEND_PATH" "$DELIVER" "$CAPITALIZATION_VARIANTS" )

case $2 in
	$GET_WINDOWS_PATH)
		exec sed 's/^\/\([[:alpha:]]*\)\//\U\1:\//g' | sed 's/\//\\/g'
		;;
	$GET_ESCAPED_PATH)
		exec sed 's/\//\\\//g' | sed 's/\ /\\\ /g'
		;;
	$REMOVE_PATH)
		readonly PATH_PARAMETER="$3"
		if [[ -z $PATH_PARAMETER ]]
		then
			echo "Path to filter cannot be empty!  Correct usage: scaffold util ${REMOVE_PATH} \"/your/path/here\"" >&2
			exit 1
		fi
		readonly PATH_REPLACE=$( echo "${PATH_PARAMETER}/" | scaffold util "${GET_ESCAPED_PATH}" )
		
		exec sed "s/$PATH_REPLACE//g"
		;;
	$REMOVE_MOD_PATH)
		source "$SCAFFOLD_PATH_CONFIG_MOD"
		exec scaffold util remove-path "$SCAFFOLD_MOD_PATH"
		;;
	$REMOVE_MOD_DATA_PATH)
		source "$SCAFFOLD_PATH_CONFIG_MOD"
		exec scaffold util remove-path "$SCAFFOLD_PATH_MOD_DATA"
		;;
	$FORMAT_FOR_ACHLIST)
		exec sed 's/\//\\\\/g' | awk '{print "\t\"" $0 "\","}'
		;;
	$PREPEND_PATH)
		readonly PATH_PARAMETER="$3"
		if [[ -z "$PATH_PARAMETER" ]]
		then
			echo "Path to filter cannot be empty!  Correct usage: scaffold util $PREPEND_PATH \"/your/path/here\"" >&2
			exit 1
		fi
		readonly PREFIX=$( echo "$PATH_PARAMETER/" | scaffold util get-escaped-path )
		
		exec sed "s/^/$PREFIX/g"
		;;
	$DELIVER)
		source "$SCAFFOLD_PATH_CONFIG_MOD"
		source "$SCAFFOLD_PATH_CONFIG_GAME"
		source "$SCAFFOLD_PATH_CONFIG_DELIVERABLE"
		
		if [[ ! -d "$SCAFFOLD_PATH_GAME_DELIVERABLE_TEMP_DATA" ]]
		then
			echo "Deliverables staging data directory does not exist, cannot deliver files" >&2
			exit 1
		fi
		
		if [[ -z $3 ]]
		then
			readonly SOURCE_DATA_PATH="$SCAFFOLD_PATH_MOD_DATA"
		else
			readonly SOURCE_DATA_PATH="$SCAFFOLD_PATH_MODS/$3/$SCAFFOLD_NAME_DIRECTORY_DATA"
		fi
		
		if [[ ! -d "$SOURCE_DATA_PATH" ]]
		then
			echo "Source mod data path does not exist, cannot deliver files" >&2
			exit 1
		fi
		
		while read COPY_THIS
		do
			SOURCE="$SOURCE_DATA_PATH/$COPY_THIS"
			TARGET="$SCAFFOLD_PATH_GAME_DELIVERABLE_TEMP_DATA/$COPY_THIS"
			
			PARENT=$( dirname "$TARGET")
			if [[ ! -d PARENT ]]
			then
				mkdir -p "$PARENT"
			fi
			
			if [[ -f $SOURCE ]]
			then
				cp -f "$SOURCE" "$TARGET"
			elif [[ -d $SOURCE ]]
			then
				cp -rf "$SOURCE" "$TARGET"
			else
				echo "Cannot deliver nonexistant path: $SOURCE" >&2
			fi
		done
		;;
	$CAPITALIZATION_VARIANTS)
		while read VALUE
		do
			echo "$VALUE" | tr '[:upper:]' '[:lower:]'
			echo "$VALUE" | tr '[:lower:]' '[:upper:]'
		done
		;;
	*)
	
	echo "Available options are: ${COMMANDS[@]}" >&2
	exit 1
esac
