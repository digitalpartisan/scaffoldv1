source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"

function listPlugins() {
	for PLUGIN_EXTENSION in "${SCAFFOLD_MOD_EXTENSIONS_PLUGIN[@]}"
	do
		find "${SCAFFOLD_MOD_PATH_DATA}" -type f -name "*.${PLUGIN_EXTENSION}" | scaffold util removemoddatapath
	done
}

function listFirstPlugin() {
	for PLUGIN_EXTENSION in "${SCAFFOLD_MOD_EXTENSIONS_PLUGIN[@]}"
	do
		FILENAME="${SCAFFOLD_MOD_NAME}.${PLUGIN_EXTENSION}"
		if [[ -f "${SCAFFOLD_MOD_PATH_DATA}/${FILENAME}" ]]
		then
			echo $FILENAME
			return
		fi
	done
}

if [[ $RELEASING == 1 ]]
then
	listFirstPlugin
else
	listPlugins
fi
