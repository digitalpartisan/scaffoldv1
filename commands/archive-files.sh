function findModPackageFiles() {
	if [[ -z $1 ]]
	then
		return
	fi
	
	MOD_PATH="$SCAFFOLD_PATH_MODS/$1"
	DATA_PATH="$MOD_PATH/$SCAFFOLD_NAME_DIRECTORY_DATA"
	EXCLUSION_FILE="$MOD_PATH/$SCAFFOLD_PATH_RELATIVE_MOD_EXCLUSIONPATTERN"
	
	COMMAND="find \"$DATA_PATH\" -type f | egrep \"\\.($SCAFFOLD_PACKAGE_EXTENSIONS)\$\""
	if [[ -r "$EXCLUSION_FILE" ]]
	then
		COMMAND="$COMMAND | grep -v --file=\"$EXCLUSION_FILE\""
	fi
	COMMAND="$COMMAND | scaffold util remove-path \"$MOD_PATH\""
	
	eval "$COMMAND"
}

source "$SCAFFOLD_PATH_CONFIG_MOD"

SCAFFOLD_PACKAGE_EXTENSIONS=$( scaffold config archive-extensions | tr "\n" "|" )
SCAFFOLD_PACKAGE_EXTENSIONS="$SCAFFOLD_PACKAGE_EXTENSIONS|$(echo $SCAFFOLD_PACKAGE_EXTENSIONS | tr [[:lower:]] [[:upper:]])"

scaffold config dependencies | while read DEPENDENCY
do
	findModPackageFiles "$DEPENDENCY"
done

findModPackageFiles "$SCAFFOLD_MOD"
