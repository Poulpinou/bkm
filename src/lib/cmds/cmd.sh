#!/bin/bash

# [----- INITIALIZE VARIABLES -----]
# [ Paths ]
# The directory of this command
COMMANDS_PATH=$(dirname "$0")

# The relative path to the lib
LIB_PATH="$COMMANDS_PATH/.."

# [ Command ]
# The name of this command
COMMAND_NAME=$(basename "$0")

# [----- LOAD UTILS -----]
. "$LIB_PATH"/utils/styles.sh
. "$LIB_PATH"/utils/messages.sh

# [----- FUNCTIONS -----]
# Displays the help for this command
_showHelp() {
  # Show command's description
  echo -e "${s_bold}[Description]${s_normal} \n"
  showDescription

  # Show command's help
  cat <<HELP

${s_bold}[Usage]${s_normal}
  $ ${s_success}bkm ${COMMAND_NAME} ${COMMAND_TARGET} [-${COMMAND_SHORT_OPTIONS/[?]/}] [--${COMMAND_LONG_OPTIONS//[,]/ --}]${s_normal}

  ${s_bold}[General Options]${s_normal}
  -h --help       ${s_bold}Help :${s_normal} Displays command's help
  -v --verbose    ${s_bold}Verbose Mode :${s_normal} Enables verbose mode. More detailed logs will be displayed.

HELP
}
