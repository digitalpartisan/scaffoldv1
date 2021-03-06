readonly SCAFFOLD_NAME_DIRECTORY_INCLUDE="include"

readonly SCAFFOLD_NAME_FILE_DEFINITIONS="definitions.sh"
readonly SCAFFOLD_NAME_FILE_ENVIRONMENTCONFIGURATION="environmentConfiguration.sh"
readonly SCAFFOLD_NAME_FILE_MODCONFIGURATION="modConfiguration.sh"
readonly SCAFFOLD_NAME_FILE_GAMECONFIGURATION="gameConfiguration.sh"
readonly SCAFFOLD_NAME_FILE_DELIVERABLECONFIGURATION="deliverableConfiguration.sh"

readonly SCAFFOLD_PATH_INCLUDE="$SCAFFOLD_PATH/$SCAFFOLD_NAME_DIRECTORY_INCLUDE"
readonly SCAFFOLD_PATH_DEFINITIONS="$SCAFFOLD_PATH_INCLUDE/$SCAFFOLD_NAME_FILE_DEFINITIONS"
readonly SCAFFOLD_PATH_CONFIG_ENVIRONMENT="$SCAFFOLD_PATH_INCLUDE/$SCAFFOLD_NAME_FILE_ENVIRONMENTCONFIGURATION"
readonly SCAFFOLD_PATH_CONFIG_MOD="$SCAFFOLD_PATH_INCLUDE/$SCAFFOLD_NAME_FILE_MODCONFIGURATION"
readonly SCAFFOLD_PATH_CONFIG_GAME="$SCAFFOLD_PATH_INCLUDE/$SCAFFOLD_NAME_FILE_GAMECONFIGURATION"
readonly SCAFFOLD_PATH_CONFIG_DELIVERABLE="$SCAFFOLD_PATH_INCLUDE/$SCAFFOLD_NAME_FILE_DELIVERABLECONFIGURATION"

source "$SCAFFOLD_PATH_DEFINITIONS"
source "$SCAFFOLD_PATH_CONFIG_ENVIRONMENT"

readonly SCAFFOLD_COMMAND_DEFAULT="help"
readonly SCAFFOLD_PATH_COMMANDS="$SCAFFOLD_PATH/$SCAFFOLD_NAME_DIRECTORY_COMMANDS"
