#!/usr/bin/env bash
## TEAM23 b5 Taskfile for Magento 2 Projects
## Version 1.6.2
##
## see https://git.team23.de/build/b5 for details

## For more info about colors take a look here:
## https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux

##########################################################
## Global Color Constants

BACKGROUND_COLOR_BLACK='40'
FONT_COLOR_HIGH_INTENSITY_RED='91'

START_COLOR="\033["
END_COLOR="m"
COMBINE_WITH=";"
TEXT_MODE_BOLD="1"

## Global Color Constants
##########################################################
## Global Formatting's

# Output formatting for commit code quality errors
TEXT_MODE_SPACER=${TEXT_MODE_BOLD}${COMBINE_WITH}
OUTPUT_COLOR_SPACER=${FONT_COLOR_HIGH_INTENSITY_RED}${COMBINE_WITH}${BACKGROUND_COLOR_BLACK}
TEXT_FORMATTING_COMMIT_ERROR=${START_COLOR}${TEXT_MODE_SPACER}${OUTPUT_COLOR_SPACER}${END_COLOR}

## Global Formatting's
