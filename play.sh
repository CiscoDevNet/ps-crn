#!/bin/sh

docker run -it --rm -v $PWD:/ps-crn --env PWD="/ps-crn" --env USER="$USER" ps-crn ansible-playbook "$@" 