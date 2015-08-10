#! /bin/sh

set -xe

if [ ! -h /var/repo.git/hooks/post-receive ]; then
  ln -s /post-receive-hook.sh /var/repo.git/hooks/post-receive
fi

fcgiwrap -f -s tcp:127.0.0.1:9000 &
nginx
sleep infinity
