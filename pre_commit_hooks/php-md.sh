#!/usr/bin/env bash
# Plugin title
title="PHPMD"

# Print a welcome and locate the exec for this tool
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/helpers/colors.sh
source $DIR/helpers/formatters.sh
source $DIR/helpers/welcome.sh
source $DIR/helpers/locate.sh

phpmd_command="b5 commit-phpmd $*"

echo -e "${bldwht}Running command ${txtgrn}$phpmd_command${txtrst}"
command_result=$(eval "b5 commit-phpmd $*")
if [[ ! $command_result == *"Task exited ok"* ]]
then
    hr
    echo -en "${bldmag}Errors detected by PHPMD ... ${txtrst} \n"
    hr
    echo "$command_result"
    exit 1
fi

exit 0