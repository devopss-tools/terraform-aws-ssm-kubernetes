## Terrafrom for deploy EKS Secrets Manager Solution


### Prepare development environment

---------------------------------------------
###### Install local tools (terraform switch versions, aws-cli, etc):
```bash
sudo bash tools-install.sh
```
###### Manage to terraform 1.0 latest stable version:
```bash
tfswitch -s 1.0
```
###### AWS configure profile credentials:
* separate IAM users KEY and SECRET without console access and with limited permissions on (SSM, KMS)  
```bash
aws configure --profile=fabacus-development
aws configure --profile=fabacus-staging
aws configure --profile=fabacus-production
```

###### Creat services .env files in case update parameter store from file


### Terrafrom apply/update and destroy (clean) infrastructure  

---------------------------------------------
###### Add tfswitch binary path to open terminal PATH:
```bash
export PATH=$HOME/bin:$PATH
terraform -v
```
###### AWS select profile to deploy (example development):
```bash
export AWS_PROFILE=fabacus-development
```
###### Export environment variables (AWS profile and ENVIRONMENT):
```bash
export PROJECT_NAME=Fabacus
export ENVIRONMENT=development
export AWS_REGION=eu-west-1
export AWS_PROFILE=fabacus-$ENVIRONMENT
```

### Terrafrom init environment

---------------------------------------------
###### Terrafrom initialize
```bash
bash bin/tf-init.sh
```

### Terrafrom deploy

---------------------------------------------
#### AWS object formats
> SSM Parameters (type: secured, encrypted):
>> /${PROJECT_NAME}/${ENVIRONMENT}/${var.service_name}-vars-secrets
> 
> KMS ecryption key tag name and alias:
>> ${PROJECT_NAME}-${ENVIRONMENT}-kms-key-alias

#### Kubernetes object formats
> SSM Parameters (type: secured, encrypted)
>> ${PROJECT_NAME}-${ENVIRONMENT}-secret

* Add service list into file terraform/services.tfvars
> ###### PROJECT_SERVICES_LIST - all services list
> ###### PROJECT_SERVICES_LIST_LOCAL_UPDATE - services from all list which will be updated from local .env.$ENVIRONMENT.service_name root project files

##### terraform/services.tfvars file example:
```yaml
PROJECT_SERVICES_LIST = [
  "web",
  "dashboard",
  "api",
  "shared",
  "cronjob-api",
  "cronjob-temp"
]
PROJECT_SERVICES_LIST_LOCAL_UPDATE = [  # make sure the file .env.$ENVIRONMENT.SERVICE  exists
  "api",
  "shared"
]
```
* In this example have to create files (if not exist default: "```default_terraform=null```"): ```.env.development.api``` and ```.env.development.shared```, on terraform apply only these two SSM Parameters will be update (content/value replace) by terraform with file contant
* 
###### Terrafrom validate configuration
```bash
bash bin/tf-deploy.sh validate
```
###### Terrafrom validate configuration
```bash
bash bin/tf-deploy.sh validate
```
###### Terrafrom plan
```bash
bash bin/tf-deploy.sh plan
```
###### Terrafrom apply
```bash
bash bin/tf-deploy.sh apply
```
###### Terrafrom destroy (require approval)
```bash
bash bin/tf-deploy.sh destroy
```