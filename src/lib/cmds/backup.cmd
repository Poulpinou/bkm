#!/bin/bash

# Load parent
. $(dirname "$0")/cmd.sh

# [----- INITIALIZE VARIABLES -----]
# Every possible options for this command
COMMAND_SHORT_OPTIONS="hvc:s:d:"
COMMAND_LONG_OPTIONS="help,verbose,config:,source:,destination:"
COMMAND_TARGET="<source> <destination>"

# [----- FUNCTIONS -----]
showHelp() {
  _showHelp
  cat << HELP
  ${s_bold}[Paths]${s_normal}
  -c --config <path>         ${s_bold}Config Path:${s_normal} the path of the config to use (default: $CONFIG_PATH)
  -s --source <path>         ${s_bold}Source Directory:${s_normal} overrides config source directory
  -d --destination <path>    ${s_bold}Destination Directory:${s_normal} overrides config source directory
HELP
}

# Displays this command's description
showDescription() {
  cat << DESCRIPTION
${s_title}${COMMAND_NAME}${s_normal}
    Creates a backup
DESCRIPTION
}

# [----- LOAD ARGUMENTS AND OPTIONS -----]
# Set default values
VERBOSE=0
SOURCE_PATH="~/Workspace/bkm_tests/source"
DESTINATION_PATH="~/Workspace/bkm_tests/destination"

# Iterate on options
while true; do
  case "$1" in
  # General
  -h | --help)
    showHelp
    exit 0
    ;;
  -v | --verbose)
    VERBOSE=1
    loginfo "Verbose mode enabled"
    shift
    ;;

  # Paths
  -c | --config)
    CONFIG_PATH="$2"
    shift 2
    ;;
  -s | --source)
    SOURCE_PATH="$2"
    shift 2
    ;;
  -d | --destination)
    DESTINATION_PATH="$2"
    shift 2
    ;;
  --)
    shift
    break
    ;;
  *) break ;;
  esac
done

# [----- Execution-----]
# Check Paths
((VERBOSE)) && echo -n "Checking source path..."
if [ ! -f $SOURCE_PATH ]; then
  ((VERBOSE)) && echo "Failed"
  echo "$SOURCE_PATH doesn't exist"
  exit 1
fi
((VERBOSE)) && echo "OK"

((VERBOSE)) && echo -n "Checking destination path..."
if [ ! -f $DESTINATION_PATH ]; then
  ((VERBOSE)) && echo "Failed"
  echo "$DESTINATION_PATH doesn't exist"
  exit 1
fi
((VERBOSE)) && echo "OK"
