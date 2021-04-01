#!/bin/bash

# Load parent
. $(dirname "$0")/cmd.sh

# [----- INITIALIZE VARIABLES -----]
# Every possible options for this command
COMMAND_SHORT_OPTIONS="hvn:f:"
COMMAND_LONG_OPTIONS="help,verbose,name:,date-format:"
COMMAND_TARGET="<source> <destination>"

# Default settings
FILE_NAME='%source%_%date%'
DATE_FORMAT='%Y_%m_%d'

# [----- FUNCTIONS -----]
showHelp() {
  _showHelp

  cat << HELP
  ${s_bold}[Backup Options]${s_normal}
  -n --name <pattern>    ${s_bold}Name pattern :${s_normal} The name patter of the backup file at destination (default: "$FILE_NAME").
                         Some variables can be used by the pattern:
                         - ${s_bold}source${s_normal}: the name of the source folder
                         - ${s_bold}destination${s_normal}: the name of the destination folder
                         - ${s_bold}date${s_normal}: the current date (default format: $DATE_FORMAT override it with the date-format option)
                         To use a variable, use this pattern: "%variable%"
  -f --date-format       ${s_bold}Date format :${s_normal} the format of every date variables (default format: $DATE_FORMAT). See https://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/
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
# [Set default values]
VERBOSE=0
NO_ARGS=0

#Check if source and destination has been provided
if [[ ! $1 == -* ]] && [[ ! $2 == -* ]]; then
  # [ Get source path ]
  if [ -z "$1" ]; then
    logError "A source is required for this command"
    exit 1
  else
    SOURCE_PATH="$1"
    shift
  fi

  # [ Get destination path ]
  if [ -z "$1" ]; then
    logError "A destination is required for this command"
    exit 1
  else
    DESTINATION_PATH="$1"
    shift
  fi
else
  NO_ARGS=1
fi

# [Prepare options]
COMMAND_OPTIONS=$(getopt -o $COMMAND_SHORT_OPTIONS --long $COMMAND_LONG_OPTIONS -n 'javawrap' -- "$@") ||
  (
    exit 1
  )
eval set -- "$COMMAND_OPTIONS"

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
    logInfo "Verbose mode enabled"
    shift
    ;;

  # Backup
  -n | --name)
    FILE_NAME="$2"
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
# [ Exit if no args ]
((NO_ARGS)) && logError  "A source and a destination are required in order to run this command" && showHelp && exit 1

#[ Check paths ]
((VERBOSE)) && logInfo "Checking paths..." -n
[ ! -d "$SOURCE_PATH" ] && logInfo "Fail" && logError "$SOURCE_PATH is not a directory" && exit 1
[ ! -d "$DESTINATION_PATH" ] && logInfo "Fail" && logError "$DESTINATION_PATH is not a directory" && exit 1
((VERBOSE)) && logSuccess "OK"

# [ Build final file name ]
((VERBOSE)) && logInfo "Building file name..." -n

source=$(basename "$SOURCE_PATH")
FILE_NAME=${FILE_NAME//'%source%'/$source}

destination=$(basename "$DESTINATION_PATH")
FILE_NAME=${FILE_NAME//'%destination%'/$destination}

date=$(date +"$DATE_FORMAT")
FILE_NAME=${FILE_NAME//'%date%'/$date}

((VERBOSE)) && logSuccess "OK"
((VERBOSE)) && logInfo "File name is $FILE_NAME"

# [ Create backup ]
echo -n "Creating backup..."
BACKUP_LOGS_PATH="$TEMP_PATH/backupLogs"
if tar -cpzf "$DESTINATION_PATH/$FILE_NAME.tar.gz" "$SOURCE_PATH" &> "$BACKUP_LOGS_PATH"; then
    logSuccess "OK"
    logSuccess "Backup successfully created at $DESTINATION_PATH/$FILE_NAME.tar.gz"
else
    echo "Fail"
    CAUSE=$(cat "$BACKUP_LOGS_PATH")
    logError "Backup creation failed: \n$CAUSE"
fi

exit 0
