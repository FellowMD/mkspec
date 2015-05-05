#!/usr/bin/env bash

sandbox_dir=`mktemp -d -t sandbox`
trap 'rm -rf $sandbox_dir' EXIT

mkspec=$(cd "$(dirname "$0")/.."; pwd)/mkspec

cd $sandbox_dir

function it {
  current_test="$1"
}

function pass {
  green='\033[0;32m'
  clear_formatting='\033[0m'
  echo -e "${green}✓ it ${current_test}${clear_formatting}"
}

function fail {
  red='\033[0;31m'
  clear_formatting='\033[0m'
  echo -e "${red}✗ it ${current_test}${clear_formatting}"
}

function wipe {
  rm -rf $sandbox_dir/*
}

function check {
  if [ "$?" == 0 ]; then
    pass
  else
    fail
  fi
  wipe
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

it 'makes directories as necessary for code'
  $mkspec app/models/code.rb
  test -f app/models/code.rb
check

it 'makes direcotries as necessary for specs'
  $mkspec models/code.rb
  test -f spec/models/code_spec.rb
check

it 'strips app from beginning of spec paths'
  $mkspec app/models/code.rb
  test -f spec/models/code_spec.rb
check

it 'uses a template for ruby specs'
  $mkspec code.rb
  grep describe spec/code_spec.rb >/dev/null
check

it 'uses no template for no extension'
  $mkspec code
  test ! -s spec/code_spec
check
