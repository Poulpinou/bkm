#!/bin/bash

# Displays an info message
# - $1 : the message to display
# - $2 : options
logInfo() {
  echo -e "$2" "${s_info}$1${s_normal}"
}

# Displays a success message
# - $1 : the message to display
# - $2 : options
logSuccess() {
  echo -e "$2" "${s_success}$1${s_normal}"
}

# Displays an error message
# - $1 : the message to display
# - $2 : options
logError() {
  echo -e "$2" "${s_error}☠ Error : $1 ☠ ${s_normal}"
  #echo -e "[$(date +'%x %X')][$0][ERROR] $1" >>$LOG_FILE
}

# Displays a warning message
# - $1 : the message to display
# - $2 : options
logWarning() {
  echo -e "$2" "${s_warning}⚠ Warning : $1 ⚠ ${s_normal}"
  #echo -e "[$(date +'%x %X')][$0][WARNING] $1" >>$LOG_FILE
}

# Exits the script and echoes custom error if there is an error
# - $1 : the exit code
# - $2 : the error message
exitIfError() {
  local exit_code=$1
  shift
  [[ $exit_code ]] && # do nothing if no error code passed
    ((exit_code != 0)) && { # do nothing if error code is 0
    logError "$@"
    exit "$exit_code"
  }
}
