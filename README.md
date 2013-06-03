gitsync
=======

Poor-man's Dropbox.

Uses git to backup a folder to a remote, and synchronize to other computers.

I use it with a private bitbucket repository to simulate Evernote,
synchronizing all my notes in a given directory.


## Installing

```bash
~/code$ git clone https://github.com/sergeio/gitsync.git
~/code$ cd gitsync
~/code/gitsync$ ./install
```

`install` will symlink `gitsync` to `~/bin/gitsync`.  So make sure `~/bin`
exists, and is on your `$PATH`.


## Using

```bash
~$ mkdir notes
~$ cd notes
~/notes$ git init
~/notes$ git remote add origin git@github.com:username/notes.git
~/notes$ gitsync start
~/notes$ echo "My first note!" > important_note.txt
```

If nothing broke, your note was automatically committed, and pushed to the
remote.  Do a `git head` to see the commit.


You can also do a `gitsync stop` to kill the background syncing process.  Note
that this is **quite unsafe**, as `gitsync stop` currently just does a `pkill
synchronizer.sh`.  You've been warned.


## Requirements

   1. ssh-keys for your git remote.
   2. `~/bin` directory on your `$PATH`.
