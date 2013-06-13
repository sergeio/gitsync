#! /bin/bash

function main () {
# Spawn 2 event loops -- one to push changes, and one to pull.
    commit_and_push_loop &
    pull_loop &
}

function commit_and_push_loop () {
# Commits anything changed, and pushes to master.
    while sleep 5; do
        if anything_has_changed; then
            commit_and_push_everything
        fi
    done
}

function pull_loop () {
# Pull from remote every hour.
    while sleep 3600; do
        git pull origin master
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

function changed_files () {
# Which files have been modified, or newly added.
    git ls-files --modified --others --deleted --directory --exclude-standard|
    xargs
}

main
