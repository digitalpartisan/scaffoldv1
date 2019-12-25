source "$SCAFFOLD_PATH_CONFIG_MOD"

readonly TEMP_FILE_EXTENSION="temp"
readonly FIRST_LINE="["
readonly LAST_LINE="]"
readonly TEMP_FILE="$SCAFFOLD_PATH_MOD_ACHLIST.$TEMP_FILE_EXTENSION"

touch "$SCAFFOLD_PATH_MOD_ACHLIST"
touch "$TEMP_FILE"

echo "$FIRST_LINE" > "$TEMP_FILE"
scaffold archive-files | scaffold util format-for-achlist >> "$TEMP_FILE"

LAST_FILE=$( tail -1 "$TEMP_FILE" )
if [[ $FIRST_LINE == $LAST_FILE ]]
then
	cat "$TEMP_FILE" > "$SCAFFOLD_PATH_MOD_ACHLIST"
else
	head -n -1 "$TEMP_FILE" > "$SCAFFOLD_PATH_MOD_ACHLIST"
	echo "$LAST_FILE" | sed 's/,//g' >> "$SCAFFOLD_PATH_MOD_ACHLIST"
fi

echo "$LAST_LINE" >> "$SCAFFOLD_PATH_MOD_ACHLIST"
rm "$TEMP_FILE"
