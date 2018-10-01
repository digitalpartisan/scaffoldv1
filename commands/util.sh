readonly GET_WINDOWS_PATH="getwindowspath"
readonly GET_ESCAPED_PATH="getescapedpath"
readonly REMOVE_PATH="removepath"
readonly REMOVE_MOD_PATH="removemodpath"
readonly REMOVE_MOD_DATA_PATH="removemoddatapath"
readonly FORMAT_FOR_ACHLIST="formatforachlist"
readonly PREPEND_PATH="prependpath"
readonly DELIVER="deliver"

readonly COMMANDS=( "$GET_WINDOWS_PATH" "$GET_ESCAPED_PATH" "$REMOVE_PATH" "$REMOVE_MOD_PATH" "$REMOVE_MOD_DATA_PATH" "$FORMAT_FOR_ACHLIST" "$PREPEND_PATH" "$DELIVER" )

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
		readonly PATH_REPLACE=$( echo "${PATH_PARAMETER}/" | scaffold util getescapedpath )
		
		exec sed "s/$PATH_REPLACE//g"
		;;
	$REMOVE_MOD_PATH)
		source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"
		exec scaffold util removepath "$SCAFFOLD_MOD_PATH"
		;;
	$REMOVE_MOD_DATA_PATH)
		source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"
		exec scaffold util removepath "$SCAFFOLD_MOD_PATH_DATA"
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
		readonly PREFIX=$( echo "$PATH_PARAMETER/" | scaffold util getescapedpath )
		
		exec sed "s/^/$PREFIX/g"
		;;
	$DELIVER)
		source "$SCAFFOLD_CONFIG_PATH_INCLUDE_DELIVERABLE_CONFIGURATION"
		
		if [[ ! -d $SCAFFOLD_DELIVERABLE_PATH_TEMP_DATA ]]
		then
			echo "Deliverables staging data directory does not exist, cannot deliver files" >&2
			exit 1
		fi
		
		if [[ -z $3 ]]
		then
			readonly SOURCE_DATA_PATH="$SCAFFOLD_MODS_LOCATION/$SCAFFOLD_MOD_NAME/$SCAFFOLD_MOD_DIRECTORY_DATA"
		else
			readonly SOURCE_DATA_PATH="$SCAFFOLD_MODS_LOCATION/$3/$SCAFFOLD_MOD_DIRECTORY_DATA"
		fi
		
		if [[ ! -d $SOURCE_DATA_PATH ]]
		then
			echo "Source mod data path does not exist, cannot deliver files" >&2
			exit 1
		fi
		
		while read COPY_THIS
		do
			SOURCE="$SOURCE_DATA_PATH/$COPY_THIS"
			TARGET="$SCAFFOLD_DELIVERABLE_PATH_TEMP_DATA/$COPY_THIS"
			
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
	*)
	
	echo "Available options are: ${COMMANDS[@]}" >&2
	exit 1
esac
