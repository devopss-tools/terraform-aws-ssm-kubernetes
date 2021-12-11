SCRIPT_DIR=$(cd `dirname "$0"` && pwd)
PROJECT_ROOT="$SCRIPT_DIR/.."

echo "Check Developpment Environment variables"
if [[ -z "$ENVIRONMENT" || -z "$AWS_REGION" || -z "$AWS_PROFILE"  ]]; then
  echo -e "\e[33m Warning: ENVIRONMENT=$ENVIRONMENT AWS_REGION=$AWS_REGION AWS_PROFILE=$AWS_PROFILE \e[0m"
  echo -e "\e[31m FAILED: export into terminal the follwing variables: ENVIRONMENT AWS_REGION AWS_PROFILE. \e[0m"
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

#
# function _urlencode() {
#   local data
#   if [[ $# != 1 ]]; then
#       echo "Usage: $0 string-to-urlencode"
#       return 1
#   fi
#   data="$(curl -s -o /dev/null -w %{url_effective} --get --data-urlencode "$1" "")"
#   if [[ $? != 3 ]]; then
#       echo "Unexpected error" 1>&2
#       return 2
#   fi
#   echo "${data##/?}"
#   return 0
# }

# function _env_file() {
#   local _efile="$PROJECT_ROOT/.env.$1"
#
#   if [ -f "$_efile" ]; then
#     echo "$_efile"
#   else
#     echo "$PROJECT_ROOT/.env"
#   fi
# }

# function _to_lower()  {
#   echo "$1" | awk '{ print tolower($1) }'
# }
#
# function _human_yes_no() {
#   [ "$1" == 1 ] && echo 'Yes' || echo 'No'
# }
#
# function _yes_no_prompt() {
#   while true; do
#     read -p ">> $1? [Y/N] " yn
#     case $yn in
#         [Yy]* ) return 1;;
#         [Nn]* ) return 0;;
#         * ) echo "Please answer yes (Y) or no (N).";;
#     esac
#   done
# }
#
# function _tf_workspace() {
#   if [[ -z "$ENVIRONMENT" || "$ENVIRONMENT" == "" ]]; then
#     _info "Exporting TF_VAR_*"
#     declare -a ENV_VARS=( "ENVIRONMENT" )
#     for _var in ${ENV_VARS[@]}; do
#       echo "export TF_VAR_${_var}=${!_var}"
#       export "TF_VAR_${_var}=${!_var}"
#     done
#   fi
#   terraform workspace list | grep $ENVIRONMENT
#   if [ $? != 0 ]; then
#     echo "Run tf command: terraform workspace new $ENVIRONMENT"
#     terraform workspace new $ENVIRONMENT
#   fi
#   terraform workspace select $ENVIRONMENT
# }
