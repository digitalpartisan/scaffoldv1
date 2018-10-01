source "$SCAFFOLD_CONFIG_PATH_INCLUDE_DELIVERABLE_CONFIGURATION"

readonly LOOSE_FLAG="--loose"
if [[ $2 == $LOOSE_FLAG ]]
then
	readonly LOOSE=1
	readonly SCAFFOLD_DELIVERABLE_PATH="$DELIVERABLE_PATH_BASE$DELIVERABLE_PATH_SEPARATOR$LOOSE_FILES"
else
	readonly LOOSE=0
	readonly SCAFFOLD_DELIVERABLE_PATH=$DELIVERABLE_PATH_BASE
fi

if [[ -d $SCAFFOLD_DELIVERABLE_PATH_TEMP_DATA || -d $SCAFFOLD_DELIVERABLE_PATH_TEMP ]]
then
	echo "Cannot build deliverable, temporary staging path already in use: $SCAFFOLD_DELIVERABLE_PATH_TEMP" >&2
	exit 1
fi

if [[ -d $SCAFFOLD_DELIVERABLE_PATH ]]
then
	echo "Cannot build deliverable, final deliverable path already in use: $SCAFFOLD_DELIVERABLE_PATH" >&2
	exit 1
fi

mkdir -p "$SCAFFOLD_DELIVERABLE_PATH_TEMP_DATA"

if [[ 1 == $LOOSE ]]
then
	scaffold config dependencies | while read DEPENDENCY
	do
		scaffold loosefiles "$DEPENDENCY" | scaffold util deliver "$DEPENDENCY"
	done
	
	scaffold loosefiles | scaffold util deliver
	
	cp -f "$SCAFFOLD_MOD_PATH_ACHLIST" "$SCAFFOLD_DELIVERABLE_PATH_TEMP"
else
	scaffold plugins --release | scaffold util deliver
	scaffold packages | scaffold util deliver
fi

mv "$SCAFFOLD_DELIVERABLE_PATH_TEMP" "$SCAFFOLD_DELIVERABLE_PATH"
