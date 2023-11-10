#!/bin/bash
source ~/repos/roit/checkout_functions.sh

BRANCH_PREFIX="conflict" 
CURRENT_BRANCH=$(git branch --show-current)
TARGET_BRANCH=${CURRENT_BRANCH#"$BRANCH_PREFIX/"}

branches $CURRENT_BRANCH $TARGET_BRANCH

if [[ "$CURRENT_BRANCH" != *"$BRANCH_PREFIX"* ]]; then
  echo_color $RED "You're not in a $BRANCH_PREFIX branch!"
  exit 1
fi

confirm "Are you sure?"

echo_color $BLUE "git fetch -ap"
git fetch -ap

echo_color $BLUE "git checkout $TARGET_BRANCH"
git checkout $TARGET_BRANCH

git ls-remote --exit-code --heads origin $CURRENT_BRANCH
REMOTE_BRANCH_EXISTS=$? 

if [[ $REMOTE_BRANCH_EXISTS == 2 ]]; then
  echo_color $RED "Remote branch doesn't exist, deleting local branch"
  echo_color $BLUE "git branch -D $CURRENT_BRANCH"
  git branch -D $CURRENT_BRANCH
fi

echo_color $BLUE "git pull"
git pull
