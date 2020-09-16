if [[ -f "$SCAFFOLD_NAME_CONFIG" ]]
then
	echo "Could not initialize mod location, configuration file already present" >&2
	exit 1
fi

cp "$SCAFFOLE_PATH_FILE_CONFIG_EXAMPLE" "$SCAFFOLD_NAME_CONFIG"
if [[ -r "$SCAFFOLD_NAME_CONFIG" ]]
then
	echo "Mod configuration initialized, please populate the values in the config file located at $SCAFFOLD_NAME_CONFIG"
else
	echo "Failed to initialize this mod location, check filesystem permissions" >&2
	exit 1
fi
