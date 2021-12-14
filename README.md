## Terrafrom for deploy AWS SSM Parameter Store Solution for Kuebrnetes secrets

* Note: Kubernetes deploy secrete into ```namespace=$ENVIRONMENT```

---------------------------------------------
##### Deploy [MikroK8s](https://microk8s.io)
###### Create kubeconfig.$ENVIRONMENT file using content of command 
```bash
microk8s config
````
* Note: can require reboot!

### Create Kubernetes Secrets

---------------------------------------------
##### Configure kube.config file for 
kubectl config view > kubeconfig.development
kubectl config view > kubeconfig.staging
kubectl config view > kubeconfig.production
###### SSM Parameter Store type SecureString and tier Standard
#### Advantages 
* Free up to 10000 parameters store (tier Standard);
* Scalable and High Availability serverless solution;
* Secure (Encryption enable using KMS);
* Automatically versioning on changes;
* Any type of Kubernetes (cloud, on-premise, hybrid);
* Easy to integrate with AWS services like code build, pipeline e.t.c.
#### Disadvantage
* Access Policy for IAM users/roles unavailable because tier Standard, it's good solution when environments are separated by AWS accounts.

### Prepare local development environment

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

[//]: # (###### Creat services .env files in case update parameter store from file)

##### [MikroK8s](https://microk8s.io) deploy for local development / testing

* Deploy MikroK8s https://microk8s.io
* Create kubeconfig file
```bash
sudo microk8s kubectl config view > kubeconfig.local
```
```bash
microk8s kubectl create namespace $ENVIRONMENT
```
##### Configure kube.config file for 
kubectl config view > kubeconfig.development
kubectl config view > kubeconfig.staging
kubectl config view > kubeconfig.production


### Terrafrom apply/update and destroy (clean) infrastructure  

---------------------------------------------
###### Add tfswitch binary path to open terminal PATH:
```bash
export PATH=$HOME/bin:$PATH
terraform -v
```

###### Export environment variables (AWS profile and ENVIRONMENT):
* PROJECT_NAME - must include only lowercase
* ENVIRONMENT  - must include only lowercase
```bash
export PROJECT_NAME=fabacus
export ENVIRONMENT=development
export AWS_REGION=eu-west-1
export AWS_PROFILE=$PROJECT_NAME-$ENVIRONMENT
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

#### Kubernetes secrets formats
> SSM Parameters (type: secured, encrypted)
>> fabacus-${ENVIRONMENT}-secret

* Add service list into file terraform/services.tfvars
> ###### PROJECT_SERVICES_LIST - all services list which secrets will have default value ```default_terraform=null``` and can be update from AWS console/CLI only (not from terraform) 
> ###### PROJECT_SERVICES_LIST_LOCAL_UPDATE - services list which secrets will be updated from local .env.$ENVIRONMENT.service_name root project files

##### terraform/services.tfvars file example:
```yaml
PROJECT_SERVICES_LIST = [
  "web",
  "dashboard",
  "api",
  "shared",
  "cronjob-api",
  "cronjob-temp",
  "shared-db-api-password",
  "shared-paypal-token",
  "shared-api-worker-cronjob",
]
PROJECT_SERVICES_LIST_LOCAL_UPDATE = [  # make sure the file .env.$ENVIRONMENT.SERVICE  exists
  "api",
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
bash bin/tf-deploy.sh
```
###### Terrafrom destroy (require approval)
```bash
bash bin/tf-deploy.sh destroy
```


### How to attache/use secrets into Kubernetes deployments

---------------------------------------------
###### List all secrets in current namespace
```bash
microk8s kubectl -n $ENVIRONMENT get secrets
```

###### Kubernetes deployment yaml 
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ...
spec:
  replicas: ...
  template:
    spec:
      containers:
      - name: ...
        image: ...
    envFrom:
    - secretRef:
        name: <K8S_SECRET_NAME_YOU_NEED>
```

### Test mount k8s secret using local [MikroK8s](https://microk8s.io)

---------------------------------------------

###### Export k8s secret name to mount into pod
```bash
microk8s kubectl get secrets
export K8S_SECRET=fabacus-development-sample-vars-secrets
```
```bash
export PROJECT_NAME=fabacus
export ENVIRONMENT=development
```
###### Create pod
```bash
cat pod.yaml.sample | envsubst | microk8s kubectl apply -f -
```
###### Describe envs and check from file ```.env.development.sample```
```bash
microk8s kubectl -n $ENVIRONMENT exec -it $K8S_SECRET env
```
