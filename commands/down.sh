source "$SCAFFOLD_PATH_CONFIG_MOD"
source "$SCAFFOLD_PATH_CONFIG_GAME"

scaffold plugins | scaffold unmap
scaffold archives | scaffold unmap
scaffold symlink-locations | scaffold unmap
