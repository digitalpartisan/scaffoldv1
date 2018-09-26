source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"
source "${SCAFFOLD_CONFIG_PATH_INCLUDE_GAME_CONFIGURATION}"

EXIT_RESULT=0

while read TARGET
do
	TARGET_PATH="${SCAFFOLD_MOD_PATH_DATA}/${TARGET}"
	LINK_PATH="${SCAFFOLD_MOD_GAME_PATH_DATA}/${TARGET}"
	
	if [[ -f "${LINK_PATH}" || -d "${LINK_PATH}" ]]
	then
		if [[ ! -f "${TARGET_PATH}" && ! -d "${TARGET_PATH}" ]]
		then
			echo "Cannot unmap file, the specified map target \"${TARGET}\" does not exist in this mod" >&2
			EXIT_RESULT=1
		else
			if [[ -f "${TARGET_PATH}" ]] && ! [[ "${LINK_PATH}" -ef "${TARGET_PATH}" ]]
			then
				cp -f "${LINK_PATH}" "${TARGET_PATH}"
			fi
			
			unlink "${LINK_PATH}"
		fi
	fi
done

exit $EXIT_RESULT
