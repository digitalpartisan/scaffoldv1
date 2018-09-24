source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"

PATH_REPLACE=$( echo "${SCAFFOLD_MOD_PATH_DATA}/" | sed 's/\//\\\//g' | sed 's/\ /\\\ /g' )

for EXTENSION in "${SCAFFOLD_MOD_EXTENSIONS_PACKAGE[@]}"
do
	find "${SCAFFOLD_MOD_PATH_DATA}" -type f -name "${SCAFFOLD_MOD_NAME}*.${EXTENSION}" | sed "s/$PATH_REPLACE//g"
done
