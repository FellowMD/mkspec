#!/usr/bin/env bash

cur_dir="$(cd "$(dirname "$0")"; pwd)"; source "${cur_dir%/spec*}/spec/shpec"

it 'passes a test'
  true
check
