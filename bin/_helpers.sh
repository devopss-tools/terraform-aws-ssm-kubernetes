SCRIPT_DIR=$(cd `dirname "$0"` && pwd)
PROJECT_ROOT="$SCRIPT_DIR/.."

echo "Check Developpment Environment variables"
if [[ -z "$ENVIRONMENT" || -z "$AWS_REGION" || -z "$AWS_PROFILE"  ]]; then
  echo -e "\e[33m Warning: ENVIRONMENT=$ENVIRONMENT AWS_REGION=$AWS_REGION AWS_PROFILE=$AWS_PROFILE \e[0m"
  echo -e "\e[31m FAILED: export into terminal the follwing variables: ENVIRONMENT AWS_REGION AWS_PROFILE. \e[0m"
  exit 1
fi

function _info() {
  echo ""
  echo " ===> $1"
  echo ""
}

function _fail() {
  if [ ! -z "$1" ]; then
    echo -e "\e[31m $1.\e[0m" 1>&2
  fi
  exit 1
}

