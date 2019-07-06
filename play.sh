#!/bin/sh

docker run -it --rm -v $PWD:/ansible --env PWD="/ansible" --env USER="$USER" ansible-viptela ansible-playbook "$@" 