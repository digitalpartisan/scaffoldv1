if [[ 0 != $( scaffold config game | grep "Not Ready" | wc -l ) ]]
then
	echo "Game location not ready for mapping, aborting procedure" >&2
	exit 1
fi
