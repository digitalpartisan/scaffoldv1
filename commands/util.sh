readonly GET_WINDOWS_PATH="getwindowspath"
readonly GET_ESCAPED_PATH="getescapedpath"
readonly REMOVE_PATH="removepath"
readonly REMOVE_MOD_PATH="removemodpath"
readonly REMOVE_MOD_DATA_PATH="removemoddatapath"
readonly FORMAT_FOR_ACHLIST="formatforachlist"
readonly PREPEND_PATH="prependpath"

readonly COMMANDS=( "${GET_WINDOWS_PATH}" "${GET_ESCAPED_PATH}" "${REMOVE_PATH}" "${REMOVE_MOD_PATH}" "${REMOVE_MOD_DATA_PATH}" "${FORMAT_FOR_ACHLIST}" "${PREPEND_PATH}" )

case $2 in
	$GET_WINDOWS_PATH)
		exec sed 's/^\/\([[:alpha:]]*\)\//\U\1:\//g' | sed 's/\//\\/g'
		;;
	$GET_ESCAPED_PATH)
		exec sed 's/\//\\\//g' | sed 's/\ /\\\ /g'
		;;
	$REMOVE_PATH)
		readonly PATH_PARAMETER="${3}"
		if [[ -z "${PATH_PARAMETER}" ]]
		then
			echo "Path to filter cannot be empty!  Correct usage: scaffold util ${REMOVE_PATH} \"/your/path/here\"" >&2
			exit 1
		fi
		readonly PATH_REPLACE=$( echo "${PATH_PARAMETER}/" | scaffold util getescapedpath )
		
		exec sed "s/$PATH_REPLACE//g"
		;;
	$REMOVE_MOD_PATH)
		source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"
		exec scaffold util removepath "${SCAFFOLD_MOD_PATH}"
		;;
	$REMOVE_MOD_DATA_PATH)
		source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"
		exec scaffold util removepath "${SCAFFOLD_MOD_PATH_DATA}"
		;;
	$FORMAT_FOR_ACHLIST)
		exec sed 's/\//\\\\/g' | awk '{print "\t\"" $0 "\","}'
		;;
	$PREPEND_PATH)
		readonly PATH_PARAMETER="${3}"
		if [[ -z "${PATH_PARAMETER}" ]]
		then
			echo "Path to filter cannot be empty!  Correct usage: scaffold util ${PREPEND_PATH} \"/your/path/here\"" >&2
			exit 1
		fi
		readonly PREFIX=$( echo "${PATH_PARAMETER}/" | scaffold util getescapedpath )
		
		exec sed "s/^/$PREFIX/g"
		;;
	*)
	
	echo "Available options are: ${COMMANDS[@]}" >&2
	exit 1
esac
