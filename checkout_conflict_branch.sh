#!/bin/bash
source ~/repos/roit/checkout_functions.sh

BRANCH_PREFIX="conflict" 
TARGET_BRANCH=$1
CURRENT_BRANCH=$(git branch --show-current)
CURRENT_BRANCH_SUGGESTION=${CURRENT_BRANCH#"$BRANCH_PREFIX/"}
CONFLICT_BRANCH=$BRANCH_PREFIX/$CURRENT_BRANCH

branches $CURRENT_BRANCH $TARGET_BRANCH

if [[ "$CURRENT_BRANCH" == *"$BRANCH_PREFIX"* ]]; then
  echo_color $RED "You're already in $BRANCH_PREFIX branch, should it be $CURRENT_BRANCH_SUGGESTION?"
  exit 1
fi

confirm "Are you sure?"

echo_color $BLUE "git checkout -b $CONFLICT_BRANCH"
git checkout -b $CONFLICT_BRANCH


echo_color $BLUE "git checkout $TARGET_BRANCH"
git checkout $TARGET_BRANCH

echo_color $BLUE "git pull"
git pull

echo_color $BLUE "git checkout $CONFLICT_BRANCH"
git checkout $CONFLICT_BRANCH

echo_color $BLUE "git merge $TARGET_BRANCH"
git merge $TARGET_BRANCH
