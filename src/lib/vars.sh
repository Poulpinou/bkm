#!/bin/bash

# [----- SETTINGS -----]]
# [Infos]
FULL_NAME="bkm - BacKup Manager"
VERSION="0.0.1"

# [Pathes]
# The path to the config file
#CONFIG_PATH="~/.bkm" # => Real value
CONFIG_PATH="$LIB_PATH/../.bkm"

# The path to commands ($LIB_PATH should be defined)
COMMANDS_PATH="$LIB_PATH/cmds"

# The path to utils ($LIB_PATH should be defined)
UTILS_PATH="$LIB_PATH/utils"

# Temp files directory
TEMP_PATH="/tmp/bkm"


# [----- CONSTRAINTS -----]
REQUIRED_FILES=("$CONFIG_PATH")
REQUIRED_DIRECTORIES=("$COMMANDS_PATH" "$UTILS_PATH")
CREATE_IF_DIRECTORY_DOESNT_EXIST=("$TEMP_PATH")


# [----- POST LOAD ACTIONS -----]
checkRequiredPaths() {
  for path in "${REQUIRED_FILES[@]}"; do
    [ ! -f "$path" ] \
      && echo "Failed to load global variables: $path doesn't exist" \
      && exit 1
  done

  for path in "${REQUIRED_DIRECTORIES[@]}"; do
    [ ! -d "$path" ] \
      && echo "Failed to load global variables: $path is not a directory" \
      && exit 1
  done

  for path in "${CREATE_IF_DIRECTORY_DOESNT_EXIST[@]}"; do
    [ ! -d "$path" ] \
      && mkdir "$path"
  done
}

checkRequiredPaths


