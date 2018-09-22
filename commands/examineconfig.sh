source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"

printf "Mod name:\t\t%s\n" "$SCAFFOLD_MOD_NAME"
printf "Game path:\t\t%s\n" "$SCAFFOLD_MOD_GAME_PATH"

printf "Dependencies:\n"

echo "${SCAFFOLD_MOD_DEPENDENCIES}" | tr ',' "\n" | while read DEPENDENCY
do
	printf "\t\t\t%s\n" "$DEPENDENCY"
done
