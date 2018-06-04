#!/usr/bin/sh
# This script uses the best practices for ssh-keygen according to
# https://stribika.github.io/2015/01/04/secure-secure-shell.html .

cd ~/.ssh

# This is the "best" key to use if possible
ssh-keygen -t ed25519 -N ""

# But the above is not as widely available/implemented as RSA keys, so also make
# one of them
ssh-keygen -t rsa -b 4096 -N ""

# I would prefer to use the `-f filename` option.  But I've found that letting
# the files go to their default location (e.g. ~/.ssh/id_rsa) allows me to not
# have to call `ssh-add` afterward to register the key with the ssh-agent.  It
# may be possible to use keys with custom names on remote servers I don't have
# root access to, but for now I'm going with the less customized path of least
# resistance.
