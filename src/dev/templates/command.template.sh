#!/bin/bash

# Load parent
. $(dirname "$0")/cmd.sh

# [----- INITIALIZE VARIABLES -----]
# Every possible options for this command
COMMAND_SHORT_OPTIONS="hv"
COMMAND_LONG_OPTIONS="help,verbose"

# Set this if command has a target before its options
COMMAND_TARGET=""

# [----- FUNCTIONS -----]
showHelp() {
  _showHelp
  # Implement the command's specific help
}

# Displays this command's description
showDescription() {
  cat << DESCRIPTION
${s_title}${COMMAND_NAME}${s_normal}
    No description available
DESCRIPTION
}

# [----- LOAD ARGUMENTS AND OPTIONS -----]
# [Prepare options]
COMMAND_OPTIONS=$(getopt -o $COMMAND_SHORT_OPTIONS --long $COMMAND_LONG_OPTIONS -n 'javawrap' -- "$@") ||
  (
    showHelp
    exit 1
  )
eval set -- "$COMMAND_OPTIONS"

# [Set default values]
VERBOSE=0

# [Iterate on options]
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

  # Handle your options

  --)
    shift
    break
    ;;
  *) break ;;
  esac
done

# [----- Execution-----]

# Implement execution here

exit 0
