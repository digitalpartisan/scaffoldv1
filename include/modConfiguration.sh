if [[ -r $SCAFFOLD_MOD_PATH_CONFIG_FILE ]]
then
	source "${SCAFFOLD_MOD_PATH_CONFIG_FILE}"
else
	echo "No mod config file detected, has this location been initialized?" >&2
	exit 1
fi

if [[ -z $SCAFFOLD_MOD_NAME || -z $SCAFFOLD_MOD_GAME_PATH ]]
then
	echo "Mod configuration appears incomplete, aborting" >&2
	exit 1
fi
