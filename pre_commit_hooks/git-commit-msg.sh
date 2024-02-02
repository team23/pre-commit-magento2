#!/usr/bin/env bash
# Plugin title
title="Git Commit Message Hook"

# Print a welcome and locate the exec for this tool
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/helpers/colors.sh
source $DIR/helpers/formatters.sh
source $DIR/helpers/welcome.sh
source $DIR/helpers/locate.sh

check_git_commit_msg="git log -1 --pretty=%B | head -n 1"

echo -e "${bldwht}Running command ${txtgrn}$check_git_commit_msg${txtrst}"
command_result=$(eval "b5 commit-phpstan $*")
if [[ ! $command_result == *"Task exited ok"* ]]
then
    hr
    echo -en "${bldmag}Your git commit message does not meet the commit message convention... ${txtrst} \n"
    hr
    echo "$command_result"
    exit 1
fi

exit 0