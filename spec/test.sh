#!/usr/bin/env bash


mkspec=$(cd "$(dirname "$0")/.."; pwd)/mkspec

source `dirname $0`/shpec


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

it 'uses bash template for shell specs'
  $mkspec code.sh
  grep bash spec/code_spec.sh >/dev/null
check

it 'copies shpec to the spec folder'
  $mkspec lib/code.sh
  test -f spec/shpec
check

it 'does not overwrite an existing shpec'
  mkdir spec
  echo still here > spec/shpec
  $mkspec code.sh
  grep 'still here' spec/shpec >/dev/null
check

it 'does not copy shpec for non-shell specs'
  $mkspec thing
  test ! -f spec/shpec
check
