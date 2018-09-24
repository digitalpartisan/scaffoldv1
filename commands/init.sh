if [[ -d "${SCAFFOLD_MOD_PATH_CONFIG}" ]]
then
	echo "Could not initialize mod location, configuration directory already present" >&2
	exit 1
fi

cp -R "${SCAFFOLD_CONFIG_PATH_SAMPLE_CONFIG}" "${SCAFFOLD_MOD_PATH_CONFIG}"
if [[ -f "${SCAFFOLD_MOD_PATH_CONFIG_FILE}" ]]
then
	echo "Mod configuration initialized, please populate the values in the config file located at ${SCAFFOLD_MOD_PATH_CONFIG_FILE}"
else
	echo "Failed to initialize this mod location, check filesystem permissions" >&2
	exit 1
fi
