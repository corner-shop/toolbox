#!/usr/bin/bash -l

set -e
usermod -u ${UID} user
groupmod -g ${GID} user
groupmod -G tty,users,docker,git user
chown -R user:user /home/user

export USER=user

ARGUMENTS="$@"
echo "Running: $ARGUMENTS"

/usr/bin/su-exec user bash -lc "$ARGUMENTS"
