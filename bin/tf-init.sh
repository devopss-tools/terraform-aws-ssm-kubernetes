#!/usr/bin/env bash

SCRIPT_DIR=$(cd `dirname "$0"` && pwd)
PROJECT_ROOT="$SCRIPT_DIR/.."

source "$SCRIPT_DIR/_helpers.sh"
declare -a ENV_VARS=( "AWS_REGION" "ENVIRONMENT" )
for _var in ${ENV_VARS[@]}; do
  echo "export TF_VAR_${_var}=${!_var}"
  export "TF_VAR_${_var}=${!_var}"
done

_info "Accessing terraform working directory"
cd "$PROJECT_ROOT/terraform" || _fail
#
# _info "Initialize terraform backend"
# terraform -chdir="./backend" init || _fail
#
# _info "Provision backend infrastructure"
# terraform -chdir="./backend"  apply -auto-approve || _fail

_info "Initialize terraform"
terraform -chdir="./environments/$ENVIRONMENT" init  || _fail
