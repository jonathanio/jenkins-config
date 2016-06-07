#!/bin/bash

GEM_HOME="$(ruby -e 'print Gem.user_dir' 2> /dev/null)"
PATH=${GEM_HOME}/bin:${PATH}
export GEM_HOME PATH

kitchen version
echo
kitchen list
echo
kitchen test
