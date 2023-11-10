#!/bin/bash

# Colors
RED="\e[31m"
BLUE="\e[34m"

echo_color() {
  COLOR=$1
  TEXT=$2
  END_COLOR="\e[0m"

  echo -e $COLOR$TEXT$END_COLOR
}

branches () {
  CURRENT_BRANCH=$1
  TARGET_BRANCH=$2

  echo -n "Current branch: "; 
  echo_color $RED $CURRENT_BRANCH

  echo -n "Target branch: "; 
  echo_color $BLUE $TARGET_BRANCH
}

confirm() {
  read -p "$1 (y/n): " -n 1 -r
  echo    # (optional) move to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]] 
  then
      exit 1
  fi
}