function findModPackageFiles() {
	if [[ -z $1 ]]
	then
		return
	fi
	
	MOD_PATH="${SCAFFOLD_MODS_LOCATION}/$1"
	PATH_REPLACE=$( echo "${MOD_PATH}/" | sed 's/\//\\\//g' | sed 's/\ /\\\ /g')
	DATA_PATH="${MOD_PATH}/${SCAFFOLD_MOD_DIRECTORY_DATA}"
	EXCLUSION_FILE="${MOD_PATH}/${SCAFFOLD_MOD_RELATIVE_PATH_PACKAGE_EXCLUSIONS}"
	
	for EXTENSION in "${SCAFFOLD_PACKAGE_EXTENSIONS[@]}"
	do
		if [[ -r $EXCLUSION_FILE ]]
		then
			find "${DATA_PATH}" -type f -name "*.$EXTENSION" | grep -v --file="${EXCLUSION_FILE}" | sed "s/$PATH_REPLACE//g"
		else
			find "${DATA_PATH}" -type f -name "*.$EXTENSION" | sed "s/$PATH_REPLACE//g"
		fi
	done
}

source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"

SCAFFOLD_PACKAGE_EXTENSIONS=()
while read EXTENSION
do
	SCAFFOLD_PACKAGE_EXTENSIONS+=( $(echo "${EXTENSION,,}") )
	SCAFFOLD_PACKAGE_EXTENSIONS+=( $(echo "${EXTENSION^^}") )
done < "$SCAFFOLD_CONFIG_PATH_PACKAGE_EXTENSIONS"

SCAFFOLD_MODS_LOCATION=$( dirname "${SCAFFOLD_MOD_PATH}" )
echo "${SCAFFOLD_MOD_DEPENDENCIES}" | tr ',' "\n" | while read DEPENDENCY
do
	findModPackageFiles "${DEPENDENCY}"
done

findModPackageFiles "${SCAFFOLD_MOD_NAME}"
