function findModPackageFiles() {
	if [[ -z $1 ]]
	then
		return
	fi
	
	MOD_PATH="$SCAFFOLD_MODS_LOCATION/$1"
	DATA_PATH="$MOD_PATH/$SCAFFOLD_MOD_DIRECTORY_DATA"
	EXCLUSION_FILE="$MOD_PATH/$SCAFFOLD_MOD_RELATIVE_PATH_EXCLUSION_FILE"
	
	COMMAND="find \"$DATA_PATH\" -type f | egrep \"\\.($SCAFFOLD_PACKAGE_EXTENSIONS)\$\""
	if [[ -r $EXCLUSION_FILE ]]
	then
		COMMAND="$COMMAND | grep -v --file=\"$EXCLUSION_FILE\""
	fi
	COMMAND="$COMMAND | scaffold util removepath \"$MOD_PATH\""
	
	eval "$COMMAND"
}

source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"

SCAFFOLD_PACKAGE_EXTENSIONS=$( scaffold config packageextensions | tr "\n" "|" )
SCAFFOLD_PACKAGE_EXTENSIONS="$SCAFFOLD_PACKAGE_EXTENSIONS|$(echo $SCAFFOLD_PACKAGE_EXTENSIONS | tr [[:lower:]] [[:upper:]])"

scaffold config dependencies | while read DEPENDENCY
do
	findModPackageFiles "$DEPENDENCY"
done

findModPackageFiles "$SCAFFOLD_MOD_NAME"
