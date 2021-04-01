#!/bin/bash

# [----- INITIALIZE VARIABLES -----]
# [ Paths ]
# This script's absolute path
SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIRECTORY=$(dirname "$SCRIPT_PATH")

# The path of execution
EXECUTION_PATH=$(dirname "$0")

# The relative path to the lib
LIB_PATH="$SCRIPT_DIRECTORY/.."

# [ Command ]
# Base options for this command
COMMAND_SHORT_OPTIONS="hv"
COMMAND_LONG_OPTIONS="help,verbose"

# The name of this command
COMMAND_NAME=$(basename "$0" .cmd)

# [----- LOAD DEPENDENCIES -----]
. "$LIB_PATH"/vars.sh
. "$UTILS_PATH"/styles.sh
. "$UTILS_PATH"/messages.sh
. "$CONFIG_PATH"

# [----- FUNCTIONS -----]
# Displays the help for this command
_showHelp() {
  # Show command's description
  echo -e "${s_title}[Description]${s_normal} \n"
  showDescription

  # Show command's help
  cat <<HELP

${s_title}[Usage]${s_normal}
  $ ${s_success}bkm ${COMMAND_NAME} ${COMMAND_TARGET} [-${COMMAND_SHORT_OPTIONS/[?]/}] [--${COMMAND_LONG_OPTIONS//[,]/ --}]${s_normal}

  ${s_title}[General Options]${s_normal}
  -h --help       ${s_bold}Help :${s_normal} Displays command's help
  -v --verbose    ${s_bold}Verbose Mode :${s_normal} Enables verbose mode. More detailed logs will be displayed.

HELP
}
