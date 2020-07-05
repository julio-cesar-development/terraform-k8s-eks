resource "null_resource" "generate_kubeconfig" {
  count = var.generate_kubeconfig_count

  provisioner "local-exec" {
    command = <<CMD_EOF

# install aws-iam-authenticator
if [ -z $(which aws-iam-authenticator) ]; then
  curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator
  chmod +x ./aws-iam-authenticator && mv ./aws-iam-authenticator /usr/local/bin/
fi

cat <<EOF>> $CLUSTER_NAME-kubeconfig.yaml
apiVersion: v1
clusters:
- cluster:
    server: $CLUSTER_ENDPOINT
    certificate-authority-data: $CLUSTER_CA_CERTIFICATE
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "k8s-cluster"
EOF

CMD_EOF

    environment = {
      CLUSTER_NAME           = module.master.eks_cluster.name
      CLUSTER_ENDPOINT       = module.master.eks_cluster.endpoint
      CLUSTER_CA_CERTIFICATE = module.master.eks_cluster.certificate_authority.0.data
      AWS_ACCESS_KEY_ID      = var.aws_access_key
      AWS_SECRET_ACCESS_KEY  = var.aws_secret_key
    }
  }

  depends_on = [module.master.eks_cluster]
}
