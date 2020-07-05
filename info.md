# Info

> Options to deploy

```bash
terraform fmt -write=true -recursive

terraform init -backend=true && \
  terraform validate && \
  terraform plan && \
  terraform apply -auto-approve

terraform refresh
```

> Checking the K8S API

```bash
export CLUSTER_ENDPOINT=$(terraform output endpoint)
export CLUSTER_TOKEN=$(terraform output kube_config_token)

# get health
curl "$CLUSTER_ENDPOINT/healthz" --silent --insecure --header "Authorization: Bearer $CLUSTER_TOKEN"

# get liveness
curl "$CLUSTER_ENDPOINT/livez" --silent --insecure --header "Authorization: Bearer $CLUSTER_TOKEN"

# list namespaces
curl "$CLUSTER_ENDPOINT/api/v1/namespaces" --silent --insecure \
  --header "Authorization: Bearer $CLUSTER_TOKEN" | jq -r '.items[].metadata.name'

# list pods
curl "$CLUSTER_ENDPOINT/api/v1/pods" --silent --insecure \
  --header "Authorization: Bearer $CLUSTER_TOKEN" | jq -r '.items[].metadata.name'
```

> Get K8S cluster token

```bash
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator && mv ./aws-iam-authenticator /usr/local/bin/

export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-"sa-east-1"}"
export CLUSTER_NAME="${CLUSTER_NAME:-"k8s-cluster"}"
export TOKEN=$(aws-iam-authenticator token -i ${CLUSTER_NAME} --region ${AWS_DEFAULT_REGION} | jq -r .status.token)
```
