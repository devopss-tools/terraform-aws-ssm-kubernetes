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
```bash
bash bin/tf-init.sh
```

###### Terrafrom plan
```bash
terraform plan
```

###### Terrafrom initialize
```bash
terraform apply
```
###### Terrafrom destroy
```bash
terraform destroy
```