#!/usr/bin/bash -l

set -e
usermod -u ${UID} user
groupmod -g ${GID} user
usermod -G tty,users,docker,git user
find /home/user -xdev  \! -user user -exec chown user:user {} \;

export USER=user

ARGUMENTS="$@"
echo "Running: $ARGUMENTS"

/usr/bin/su-exec user bash -lc "$ARGUMENTS"
