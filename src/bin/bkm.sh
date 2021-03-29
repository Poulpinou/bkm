#!/bin/bash

# [----- INITIALIZE VARIABLES -----]
#[Paths]
# Real values
#CONFIG_PATH="~/.bkm"
#LIB_PATH="/usr/libexec/bkm"

# Dev values
CONFIG_PATH="../.bkm"
LIB_PATH="../lib"

#[Infos]
FULL_NAME="bkm - BacKup Manager"
VERSION="0.0.1"

#[Commands]
COMMAND_SHORT_OPTIONS="hvVlc:"
COMMAND_LONG_OPTIONS="help,verbose,version,list,config:"

# [----- LOAD UTILS -----]
. $LIB_PATH/utils/styles.sh
. $LIB_PATH/utils/messages.sh

# [----- FUNCTIONS -----]
showHelp() {
  cat <<HELP
Usage:
  ${s_success}$ bkm [-${COMMAND_SHORT_OPTIONS/[?]/}] [--${COMMAND_LONG_OPTIONS//[,]/ --}]${s_normal}
  ${s_bold}[Options]${s_normal}
  -h --help        ${s_bold}Help :${s_normal} Displays global help
  -v --verbose     ${s_bold}Verbose Mode :${s_normal} Enables verbose mode. More detailed logs will be displayed.
  -V --version     ${s_bold}Version:${s_normal} Displays bkm current version
  -l --list        ${s_bold}List Commands :${s_normal} Displays every possible command for bkm

  ${s_success}$ bkm <command> [-${COMMAND_SHORT_OPTIONS/[?]/}] [--${COMMAND_LONG_OPTIONS//[,]/ --}] [{commands-options}]${s_normal}
  ${s_bold}[General Options]${s_normal}
  -h --help        ${s_bold}Help :${s_normal} Displays command's help
  -v --verbose     ${s_bold}Verbose Mode :${s_normal} Enables verbose mode. More detailed logs will be displayed.
HELP
}

listCommands() {
  echo "${s_bold}[Available bkm commands]${s_normal}"
  echo

  for cmd in "$LIB_PATH"/cmds/*.cmd; do
    COMMAND_NAME=$(basename "$cmd")
    t=$(sed -n -e '1,/cat << DESCRIPTION/d;/DESCRIPTION/q;p' "$cmd")
    eval "echo \"$t\""
    echo
  done

  echo "Use \"bkm <command> -h\" to see usage"
}

# [----- LOAD ARGUMENTS AND OPTIONS -----]
# [ Check empty arguments ]
if [ -z "$1" ]; then
  logError "Some arguments or options are required for this command"
  showHelp
  exit 0
fi

# [ Check if a command is passed ]
if [[ ! $1 == -* ]]; then # A command has been provided
  # [ Extract command from arguments]
  COMMAND="$1"
  shift

  # [ Check if command exists ]
  [ -f $LIB_PATH/cmds/"$COMMAND".cmd ] || exitIfError 1 "The \"$COMMAND\" command does not exist"

  # [ Execute command ]
  bash "$LIB_PATH"/cmds/"$COMMAND".cmd "$@"

# [ No command provided ]
else
  # Prepare options
  COMMAND_OPTIONS=$(getopt -o $COMMAND_SHORT_OPTIONS --long $COMMAND_LONG_OPTIONS -n 'javawrap' -- "$@") ||
    (
      showHelp
      exit 1
    )
  eval set -- "$COMMAND_OPTIONS"

  # Set default values
  VERBOSE=0

  # Iterate on options
  while true; do
    case "$1" in
    -h | --help)
      showHelp
      exit 0
      ;;
    -v | --verbose)
      VERBOSE=1
      logInfo "Verbose mode enabled"
      shift
      ;;
    -V | --version)
      echo "$FULL_NAME v$VERSION"
      exit 0
      ;;
    -l | --list)
      listCommands
      exit 0
      ;;
    --)
      shift
      break
      ;;
    *) break ;;
    esac
  done
fi

#[Execution]
# Load config
#CONFIG_PATH=${CONFIG_PATH/[~]/"/home/${USER}"}
#((VERBOSE)) && echo -n "Checking config path..."
#if [ ! -f $CONFIG_PATH ]; then
#	((VERBOSE)) && echo "Failed"
#	echo "$CONFIG_PATH doesn't exist"
#
#	while true; do
#		read -p "Do you want to create one at $CONFIG_PATH? [y/n]" yn
#    		case $yn in
#       			[Yy]* )
#				((VERBOSE)) && echo -n "Creating configuration file..."
#				createConfigFile
#				((VERBOSE)) && echo "OK"
#				break;;
#        		[Nn]* ) echo "Aborting: No congig file"; exit 1;;
#        		* ) echo "Please answer yes or no.";;
#    		esac
#	done
#else
#	((VERBOSE)) && echo "OK"
#fi
#
#((VERBOSE)) && echo -n "Loading config from $CONFIG_PATH..."
#. $CONFIG_PATH
#((VERBOSE)) && echo "OK"
#
#exit 0
exit 1
