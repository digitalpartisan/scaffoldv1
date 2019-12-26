source "$SCAFFOLD_PATH_CONFIG_MOD"
source "$SCAFFOLD_PATH_CONFIG_GAME"

if [[ 1 == $RELEASING ]]
then
	scaffold archives | scaffold map
	scaffold plugins --release | scaffold map
else
	scaffold symlink-locations | scaffold map
	scaffold plugins | scaffold map
fi
