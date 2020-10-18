source "$SCAFFOLD_PATH_CONFIG_MOD"
source "$SCAFFOLD_PATH_CONFIG_GAME"
source "$SCAFFOLD_PATH_CONFIG_DELIVERABLE"

if [[ -d "$SCAFFOLD_PATH_GAME_DELIVERABLE_TEMP_DATA" || -d "$SCAFFOLD_PATH_GAME_DELIVERABLE_TEMP" ]]
then
	echo "Cannot build deliverable, temporary staging path already in use: $SCAFFOLD_PATH_GAME_DELIVERABLE_TEMP" >&2
	exit 1
fi

if [[ -d "$SCAFFOLD_PATH_DELIVERABLE" ]]
then
	echo "Cannot build deliverable, final deliverable path already in use: $SCAFFOLD_PATH_DELIVERABLE_MOD" >&2
	exit 1
fi

mkdir -p "$SCAFFOLD_PATH_GAME_DELIVERABLE_TEMP_DATA"

if [[ $LOOSE ]]
then
	scaffold config dependencies | while read DEPENDENCY
	do
		scaffold loose-files "$DEPENDENCY" | scaffold util deliver "$DEPENDENCY"
	done
	
	scaffold loose-files | scaffold util deliver
	
	cp -f "$SCAFFOLD_PATH_MOD_ACHLIST" "$SCAFFOLD_PATH_GAME_DELIVERABLE_TEMP"
else
	scaffold plugins --release | scaffold util deliver
	scaffold archives | scaffold util deliver
fi

mv "$SCAFFOLD_PATH_GAME_DELIVERABLE_TEMP" "$SCAFFOLD_DELIVERABLE_PATH"
