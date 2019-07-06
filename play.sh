#!/bin/sh

docker run -it --rm -v $PWD:/ansible --env PWD="/ansible" --env USER="$USER" --env VIRL_SESSION="$VIRL_SESSION" ansible-viptela ansible-playbook "$@" 