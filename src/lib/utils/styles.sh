#!/bin/bash

# [----- STYLES -----]
s_normal=$(tput sgr0)
s_bold=$(tput bold)
s_error=$(tput setaf 7; tput setab 1)
s_warning=$(tput setaf 3)
s_success=$(tput setaf 2)
s_info=$(tput dim)
s_title=$(tput bold; tput setaf 3)