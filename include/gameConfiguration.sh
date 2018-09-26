readonly GAME_CONFIG_SUCCESS=$( scaffold config game | grep "Not Ready" | wc -l )
if [[ 0 != $GAME_CONFIG_SUCCESS ]]
then
	echo "Game location not ready for mapping, aborting procedure" >&2
	exit 1
fi
