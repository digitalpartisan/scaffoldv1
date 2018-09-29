source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"

if [[ -z $SCAFFOLD_MOD_DELIVERABLES_PATH ]]
then
	echo "Mod deliverable path is not configured, cannot build deliverable" >&2
	exit 1
fi
