# Info

> Options to deploy

```bash
set -e

terraform fmt -write=true -recursive

terraform init -backend=true && \
  terraform validate && \
  terraform plan && \
  terraform apply -auto-approve
```

> Get K8S cluster token

```bash
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator && mv ./aws-iam-authenticator /usr/local/bin/

export CLUSTER_NAME="${CLUSTER_NAME:-"k8s-cluster"}"
export TOKEN=$(aws-iam-authenticator token -i ${CLUSTER_NAME} | jq -r .status.token)
```
