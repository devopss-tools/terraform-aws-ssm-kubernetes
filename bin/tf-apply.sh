#!/usr/bin/env bash

SCRIPT_DIR=$(cd `dirname "$0"` && pwd)
PROJECT_ROOT="$SCRIPT_DIR/.."

source "$SCRIPT_DIR/_helpers.sh"

declare -a ENV_VARS=( "AWS_REGION" "ENVIRONMENT" "PROJECT_NAME" )
for _var in ${ENV_VARS[@]}; do
  echo "export TF_VAR_${_var}=${!_var}"
  export "TF_VAR_${_var}=${!_var}"
done

_info "Accessing terraform working directory"
cd "$PROJECT_ROOT/terraform" || _fail

if [[ $1 == "plan" ]]; then
  _info "terraform plan"
  terraform -chdir="./environments/$ENVIRONMENT" plan -lock=false -var-file="../../services.tfvars" || _fail
else
  _info "terraform apply"
  terraform -chdir="./environments/$ENVIRONMENT" apply -auto-approve -var-file="./services.tf" || _fail
  terraform -chdir="./environments/$ENVIRONMENT" outputs || _fail
fi
