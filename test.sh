sandbox_dir=`mktemp -d -t sandbox`
trap 'rm -rf $sandbox_dir' EXIT

mkspec_path=`dirname $0`/mkspec

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
  test -x $mkspec_path
check
