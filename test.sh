#!/usr/bin/env bash

sandbox_dir=`mktemp -d -t sandbox`
trap 'rm -rf $sandbox_dir' EXIT

mkspec=`dirname $0`/mkspec

pushd $sandbox_dir

function check {
  if [ "$?" == 0 ]; then
    echo '✓'
  else
    echo '✗'
    exit 1
  fi
}

function it {
  current_test="$1"
}
function pass {
  green='\033[0;32m'
  clear_formatting='\033[0m'
  echo -e "${green}it ${current_test}...✓${clear_formatting}"
}
function fail {
  red='\033[0;31m'
  clear_formatting='\033[0m'
  echo -e "${red}it ${current_test}...✗${clear_formatting}"
}

function check {
  if [ "$?" == 0 ]; then
    pass
  else
    fail
  fi
}

it 'exists'
  test -x $mkspec
check

it 'creates the production code file'
  $mkspec code
  test -f code
check

it 'creates the spec file'
  $mkspec code
  test -f spec/code_spec
check

it 'preserves extension of prod file'
  $mkspec code.rb
  test -f code.rb
check

it 'creates spec file with proper extension'
  $mkspec code.rb
  test -f spec/code_spec.rb
check

# it 'makes directories as necessary for code'
#   $mkspec app/code.rb
#   test -d app
# check
