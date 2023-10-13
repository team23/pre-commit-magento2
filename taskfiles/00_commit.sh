#!/usr/bin/env bash
## TEAM23 b5 Taskfile for Magento 2 Projects
## Version 1.6.2
##
## see https://git.team23.de/build/b5 for details

##########################################################
## Pre-Commit Functions

source ./taskfiles/00_commit_functions.sh 2>/dev/null

task:commit-phpcs() {
    commit-phpcs "$@"
}

task:commit-phpstan() {
    commit-phpstan "$@"
}

task:commit-phpmd() {
    commit-phpmd "$@"
}

task:commit-eslint() {
    commit-eslint "$@"
}

## Pre-Commit Functions
##########################################################
