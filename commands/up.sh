source "$SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION"
source "$SCAFFOLD_CONFIG_PATH_INCLUDE_GAME_CONFIGURATION"

if [[ 1 == $RELEASING ]]
then
	scaffold packages | scaffold map
	scaffold plugins --release | scaffold map
else
	scaffold symlinklocations | scaffold map
	scaffold plugins | scaffold map
fi
