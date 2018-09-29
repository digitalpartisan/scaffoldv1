if [[ -z $SCAFFOLD_MOD_DELIVERABLES_PATH ]]
then
	echo "Mod deliverable path is not configured, cannot build deliverable" >&2
	exit 1
fi

readonly LOOSE_FILES="Loose"
readonly DELIVERABLE_PATH_SEPARATOR="_"
readonly DELIVERABLE_PATH="$SCAFFOLD_MOD_DELIVERABLES_PATH/$SCAFFOLD_MOD_NAME"
readonly DELIVERABLE_PATH_DATA="$DELIVERABLE_PATH/$SCAFFOLD_MOD_DIRECTORY_DATA"
readonly DELIVERABLE_PATH_LOOSE="$DELIVERABLE_PATH$DELIVERABLE_PATH_SEPARATOR$LOOSE_FILES"

if [[ -d $DELIVERABLE_PATH ]]
then
	echo "Cannot build deliverable, directory already exists: $DELIVERABLE_PATH" >&2
	exit 1
fi

mkdir "$DELIVERABLE_PATH"
mkdir "$DELIVERABLE_PATH_DATA"
