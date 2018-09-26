source "${SCAFFOLD_CONFIG_PATH_INCLUDE_MOD_CONFIGURATION}"
source "${SCAFFOLD_CONFIG_PATH_INCLUDE_GAME_CONFIGURATION}"

scaffold plugins | scaffold unmap
scaffold packages | scaffold unmap
scaffold symlinklocations | scaffold unmap
