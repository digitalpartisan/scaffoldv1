readonly SCAFFOLD_PATH_DELIVERABLE_MOD="$SCAFFOLD_GAME_DELIVERABLE_PATH/$SCAFFOLD_MOD"

readonly SCAFFOLD_PATH_GAME_DELIVERABLE_TEMP="$SCAFFOLD_GAME_DELIVERABLE_PATH/$SCAFFOLD_NAME_DIRECTORY_TEMP"
readonly SCAFFOLD_PATH_GAME_DELIVERABLE_TEMP_DATA="$SCAFFOLD_PATH_GAME_DELIVERABLE_TEMP/$SCAFFOLD_NAME_DIRECTORY_DATA"

readonly LOOSE_FLAG="--loose"
if [[ $2 == "$LOOSE_FLAG" ]]
then
	readonly LOOSE=1
	readonly SCAFFOLD_DELIVERABLE_PATH="$SCAFFOLD_PATH_DELIVERABLE_MOD$SCAFFOLD_DELIVERABLE_SEPARATOR$SCAFFOLD_DELIVERABLE_LOOSEFILES"
else
	readonly LOOSE=0
	readonly SCAFFOLD_DELIVERABLE_PATH="$SCAFFOLD_PATH_DELIVERABLE_MOD"
fi
