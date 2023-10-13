#!/usr/bin/env bash
# Plugin title
title="PHPStan"

# Print a welcome and locate the exec for this tool
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/helpers/colors.sh
source $DIR/helpers/formatters.sh
source $DIR/helpers/welcome.sh
source $DIR/helpers/locate.sh

phpstan_command="b5 commit-phpstan $*"

echo -e "${bldwht}Running command ${txtgrn}$phpstan_command${txtrst}"
command_result=$(eval "b5 commit-phpstan $*")
if [[ ! $command_result == *"Task exited ok"* ]]
then
    hr
    echo -en "${bldmag}Errors detected by PHPStan ... ${txtrst} \n"
    hr
    echo "$command_result"
    exit 1
fi

exit 0