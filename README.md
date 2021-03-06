# Terraform K8S provisioner on AWS

[![GitHub Status](https://badgen.net/github/status/julio-cesar-development/terraform-k8s-eks)](https://github.com/julio-cesar-development/terraform-k8s-eks)
![License](https://badgen.net/badge/license/MIT/blue)

## This project will provide a K8S cluster on AWS using Terraform and deploy an application

> It uses Travis CI to do the continuous integration and deployment

## Instructions

```bash
# install aws-iam-authenticator
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator && mv ./aws-iam-authenticator /usr/local/bin/

export AWS_ACCESS_KEY_ID="AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="AWS_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="AWS_DEFAULT_REGION"

chmod +x ./deploy.sh && bash ./deploy.sh

export CLUSTER_NAME="${CLUSTER_NAME:-"k8s-cluster"}"
export TOKEN=$(aws-iam-authenticator token -i ${CLUSTER_NAME} --region ${AWS_DEFAULT_REGION} | jq -r .status.token)
```

## Authors

[Julio Cesar](https://github.com/julio-cesar-development)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
