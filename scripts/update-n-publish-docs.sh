#!/bin/bash

# This script updates and publishes the protocol API documentation
# This script is intended to be run on a regular schedule, e.g. via cron.

set -x

# These locations are very machine specific.
viewer_repo_path="$HOME/code/pristine/debugger-protocol-viewer-pristine"
local_script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$viewer_repo_path" || exit
viewer_repo="origin master"

git checkout master
git pull $viewer_repo

# generate latest docs on updated protocol
yarn prep && yarn build;

git commit --author="DevTools Bot <paulirish+bot@google.com>" -am "bump protocol"
#    git config user.name "devtools-bot"
#    git config user.email "paulirish+bot@google.com"

# push protocol bump commit back to viewer repo
git pull $viewer_repo && git push $viewer_repo

# publish to https://chromedevtools.github.io/devtools-protocol/
yarn deploy
