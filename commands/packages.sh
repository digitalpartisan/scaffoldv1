source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"

for EXTENSION in "${SCAFFOLD_MOD_EXTENSIONS_PACKAGE[@]}"
do
	find "${SCAFFOLD_MOD_PATH_DATA}" -type f -name "${SCAFFOLD_MOD_NAME}*.${EXTENSION}" | scaffold util removemoddatapath
done
