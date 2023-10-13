#!/usr/bin/env bash
## TEAM23 b5 Taskfile for Magento 2 Projects
## Version 1.6.2
##
## see https://git.team23.de/build/b5 for details

## These functions are used in combination with custom pre-commit hooks
## see https://github.com/BenOchocki/pre-commit-php for further Information

##########################################################
## Pre-Commit Functions

source ./taskfiles/99_colors.sh

commit-phpcs() {
    # Error message
    ERROR=" --- Your code did not pass the PHPCS quality check! Fix your code and try again! --- "
    ERROR_MSG=" ${TEXT_FORMATTING_COMMIT_ERROR}${ERROR}${RESET_COLOR} \n"

    # Since running b5 phpcs with the prepared list of changed files results in files not found
    # (all files are concatenated into one string seperated with a space) a workaround is used

    # Get the container
    CONTAINER=$(docker-compose -f build/compose.yaml ps -q php)
    RULESET="--standard=Magento2"
    # Convert arguments to a usefully array
    FILES=( "$@" )
    # Remove src/ and web/ from all given files
    SRC="src/"
    WEB="web/"
    REMOVESRC=${FILES[*]#$SRC}
    PREPARED_FILES_LIST=${REMOVESRC[*]#$WEB}
    # Execute PHPCS
    docker exec --tty "${CONTAINER}" bash -c "./vendor/bin/phpcs $RULESET $PREPARED_FILES_LIST" ||
    if [ $? != 0 ]; then
        # PHPCS failed, print error message and quit
        echo -e "${ERROR_MSG}";
        exit 1;
    fi
}

commit-phpstan() {
    # Error message
    ERROR=" --- Your code did not pass the PHPStan quality check! Fix your code and try again! --- "
    ERROR_MSG=" ${TEXT_FORMATTING_COMMIT_ERROR}${ERROR}${RESET_COLOR} \n"

    # Since running b5 phpstan with the prepared list of changed files results in files not found
    # (all files are concatenated into one string seperated with a space) a workaround is used

    # Get the container
    CONTAINER=$(docker-compose -f build/compose.yaml ps -q php)

    PARAMS="analyze -c dev/tests/static/testsuite/Magento/Test/Php/_files/phpstan/phpstan.neon"
    RULESET="--level=max"

    # Convert arguments to a usefully array
    FILES=( "$@" )
    # Remove src/ and web/ from all given files
    SRC="src/"
    WEB="web/"
    REMOVESRC=${FILES[*]#$SRC}
    PREPARED_FILES_LIST=${REMOVESRC[*]#$WEB}
    # Execute PHPStan
    docker exec --tty "${CONTAINER}" bash -c "./vendor/bin/phpstan $PARAMS $RULESET $PREPARED_FILES_LIST" ||
    if [ $? != 0 ]; then
        # PHPStan failed, print error message and quit
        echo -e "${ERROR_MSG}";
        exit 1;
    fi
}

commit-phpmd() {
    # Error message
    ERROR=" --- Your code did not pass the PHP Mess Detector quality check! Fix your code and try again! --- "
    ERROR_MSG=" ${TEXT_FORMATTING_COMMIT_ERROR}${ERROR}${RESET_COLOR} \n"

    # Since running b5 phpmd with the prepared list of changed files results in files not found
    # (all files are concatenated into one string seperated with a space) a workaround is used

    # Get the container
    CONTAINER=$(docker-compose -f build/compose.yaml ps -q php)

    RULESET="dev/tests/static/testsuite/Magento/Test/Php/_files/phpmd/ruleset.xml"

    # Convert arguments to a usefully array
    FILES=( "$@" )
    # Remove src/ and web/ from all given files
    SRC="src/"
    WEB="web/"
    REMOVESRC=${FILES[*]#$SRC}
    PREPARED_FILES_LIST1=${REMOVESRC[*]#$WEB}
    PREPARED_FILES_LIST2=$(echo "${PREPARED_FILES_LIST1[*]}" | tr ' ' ,)
    # Execute PHPMD
    docker exec --tty "${CONTAINER}" bash -c "./vendor/bin/phpmd $PREPARED_FILES_LIST2 text $RULESET" ||
    if [ $? != 0 ]; then
        # PHPMD failed, print error message and quit
        echo -e "${ERROR_MSG}";
        exit 1;
    fi
}

commit-eslint() {
    # Error message
    ERROR=" --- Your code did not pass the ESLint quality check! Fix your code and try again! --- "
    ERROR_MSG=" ${TEXT_FORMATTING_COMMIT_ERROR}${ERROR}${RESET_COLOR} \n"

    # Since running b5 eslint with the prepared list of changed files results in files not found
    # (all files are concatenated into one string seperated with a space) a workaround is used

    # Get the container
    CONTAINER=$(docker-compose -f build/compose.yaml ps -q php)

    # Convert arguments to a usefully array
    FILES=( "$@" )
    # Remove src/ and web/ from all given files
    SRC="src/"
    WEB="web/"
    REMOVESRC=${FILES[*]#$SRC}
    PREPARED_FILES_LIST=${REMOVESRC[*]#$WEB}
    # Check if eslint is installed
    if ! is-eslint-installed; then
        download-eslint
    fi;
    # Execute ESLint
    docker exec --tty "${CONTAINER}" bash -c "./node_modules/.bin/eslint -c vendor/magento/magento-coding-standard/eslint/.eslintrc --rulesdir vendor/magento/magento-coding-standard/eslint/rules/ $PREPARED_FILES_LIST" ||
    if [ $? != 0 ]; then
        # ESLint failed, print error message and quit
        echo -e "${ERROR_MSG}";
        exit 1;
    fi
}

is-eslint-installed() {
    docker:container_run -T php /bin/sh -c "npm list eslint"
}

download-eslint() {
    b5:warn "Installing ESLint..."
    docker:container_run -T php /bin/sh -c "npm install"
}

## Pre-Commit Functions
##########################################################
