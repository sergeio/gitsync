#! /bin/bash

function main() {
# Main event loop.
    while sleep 1; do
        if anything_has_changed; then
            commit_and_push_everything
        fi
        periodically_pull_changes
    done
}

function anything_has_changed () {
# Is anything modified or untracked?
    [[ $(git status -s) != "" ]]
}

function commit_and_push_everything () {
# Commit everything, and push to master.
    filenames=$(changed_files)
    git add --all
    git commit --message="Changes: $filenames"
    git push origin master
}

function periodically_pull_changes () {
# Do a git-pull if the current time is on the minute (seconds == 0).
    if [[ $(date +%S) == 00 ]]; then
        git pull origin master
    fi
}

function changed_files () {
# Which files have been modified, or newly added.
    git ls-files --modified --others --deleted --directory |
    xargs
}

main
