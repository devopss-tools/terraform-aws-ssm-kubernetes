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
  terraform -chdir="./environments/$ENVIRONMENT" plan  -out tfplan -lock=false -var-file="../../services.tfvars" || _fail
elif [[ $1 == "output" ]]; then
  _info "terraform plan with output"
  terraform -chdir="./environments/$ENVIRONMENT" plan  -out tfplan -lock=false -var-file="../../services.tfvars"   || _fail
elif [[ $1 == "validate" ]]; then
  _info "terraform validate"
  terraform -chdir="./environments/$ENVIRONMENT" validate || _fail
elif [[ $1 == "destroy" ]]; then
  _info "terraform destroy"
  terraform -chdir="./environments/$ENVIRONMENT" destroy -var-file="../../services.tfvars" || _fail
# elif [[ $1 == "ssm" ]]; then
#   _info "terraform replace ssm"
#   terraform -chdir="./environments/$ENVIRONMENT" apply -auto-approve  -replace="module.secrets-manager.null_resource.update_ssm[\"api\"]" -var-file="../../services.tfvars" || _fail
elif [[ $1 == "secrets" ]]; then
  _info "terraform deploy secrets"
  terraform -chdir="./environments/$ENVIRONMENT" apply -auto-approve -target="module.secrets-manager" -var-file="../../services.tfvars" || _fail
else
  _info "terraform apply"
  terraform -chdir="./environments/$ENVIRONMENT" validate || _fail
  terraform -chdir="./environments/$ENVIRONMENT" apply -auto-approve -var-file="../../services.tfvars" || _fail
#   terraform -chdir="./environments/$ENVIRONMENT" output || _fail
fi
