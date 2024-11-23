#!/usr/bin/env bash

# To link the hook correctly, run this command at the root of the project:
# chmod +x scripts/*.bash && scripts/install-hooks.bash   

GIT_DIR=$(git rev-parse --git-dir)

echo "Installing hooks..."
# this command creates symlink to our pre-commit script
ln -s ../../scripts/pre-commit.bash $GIT_DIR/hooks/pre-commit
echo "Done!" 