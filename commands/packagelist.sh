source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"

readonly TEMP_FILE_EXTENSION="temp"
readonly FIRST_LINE="["
readonly LAST_LINE="]"
readonly TEMP_FILE="${SCAFFOLD_MOD_PATH_ACHLIST}.${TEMP_FILE_EXTENSION}"

touch "${SCAFFOLD_MOD_PATH_ACHLIST}"
touch "${TEMP_FILE}"

echo "${FIRST_LINE}" > "${TEMP_FILE}"
scaffold packagefiles | scaffold util formatforachlist >> "${TEMP_FILE}"

LAST_FILE=$( tail -1 "${TEMP_FILE}" )
if [[ ${FIRST_LINE} == ${LAST_FILE} ]]
then
	cat "${TEMP_FILE}" > "${SCAFFOLD_MOD_PATH_ACHLIST}"
else
	head -n -1 "${TEMP_FILE}" > "${SCAFFOLD_MOD_PATH_ACHLIST}"
	echo "${LAST_FILE}" | sed 's/,//g' >> "${SCAFFOLD_MOD_PATH_ACHLIST}"
fi

echo "${LAST_LINE}" >> "${SCAFFOLD_MOD_PATH_ACHLIST}"
rm "${TEMP_FILE}"
