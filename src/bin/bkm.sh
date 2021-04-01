#!/bin/bash

# [----- INITIALIZE VARIABLES -----]
# [ Pathes ]
# This script's absolute path
SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIRECTORY=$(dirname "$SCRIPT_PATH")

# The path of execution
EXECUTION_PATH=$(dirname "$0")

# Relative path to the lib directory
LIB_PATH="/usr/local/lib/bkm" # => Real value
#LIB_PATH="$SCRIPT_DIRECTORY/../lib" # => Dev value

#[Commands]
COMMAND_SHORT_OPTIONS="hvl"
COMMAND_LONG_OPTIONS="help,version,list"

# [----- LOAD DEPENDENCIES -----]
. "$LIB_PATH"/vars.sh
. "$UTILS_PATH"/styles.sh
. "$UTILS_PATH"/messages.sh
. "$CONFIG_PATH"

# [----- FUNCTIONS -----]
showHelp() {
  cat <<HELP
${s_title}[Usage]${s_normal}
  ${s_success}$ bkm [-${COMMAND_SHORT_OPTIONS/[?]/}] [--${COMMAND_LONG_OPTIONS//[,]/ --}]${s_normal}
  ${s_title}[Options]${s_normal}
  -h --help                  ${s_bold}Help :${s_normal} Displays global help
  -V --version               ${s_bold}Version:${s_normal} Displays bkm current version
  -l --list                  ${s_bold}List Commands :${s_normal} Displays every possible command for bkm


  ${s_success}$ bkm <command> [-${COMMAND_SHORT_OPTIONS/[?]/}] [--${COMMAND_LONG_OPTIONS//[,]/ --}] [{commands-options}]${s_normal}
  ${s_title}[General Options]${s_normal}
  -h --help        ${s_bold}Help :${s_normal} Displays command's help
  -v --verbose     ${s_bold}Verbose Mode :${s_normal} Enables verbose mode. More detailed logs will be displayed.
HELP
}

listCommands() {
  echo "${s_title}[Available bkm commands]${s_normal}"
  echo

  for cmd in "$LIB_PATH"/cmds/*.cmd; do
    COMMAND_NAME=$(basename "$cmd" .cmd)
    t=$(sed -n -e '1,/cat << DESCRIPTION/d;/DESCRIPTION/q;p' "$cmd")
    eval "echo \"  ▹ $t\""
    echo
  done

  echo "Use \"bkm <command> -h\" to see usage"
}

# [----- LOAD ARGUMENTS AND OPTIONS -----]
# [ Check empty arguments ]
if [ -z "$1" ]; then
  logError "Some arguments or options are required for this command"
  showHelp
  exit 1
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
  # [Prepare options]
  COMMAND_OPTIONS=$(getopt -o $COMMAND_SHORT_OPTIONS --long $COMMAND_LONG_OPTIONS -n 'javawrap' -- "$@") ||
    (
      showHelp
      exit 1
    )
  eval set -- "$COMMAND_OPTIONS"

  # [Iterate on options]
  while true; do
    case "$1" in
    -h | --help)
      showHelp
      shift
      ;;
    -v | --version)
      echo "$FULL_NAME v$VERSION"
      shift
      ;;
    -l | --list)
      listCommands
      shift
      ;;
    --)
      shift
      break
      ;;
    *) break ;;
    esac
  done
fi

exit 0
