resource "null_resource" "wait_cluster" {
  provisioner "local-exec" {
    command = <<CMD_EOF
# wait cluster
while [ $(curl "$CLUSTER_ENDPOINT/healthz" -o /dev/null --connect-timeout 10 --silent --insecure --header "Authorization: Bearer $CLUSTER_TOKEN"; echo $?) -ne 0 ]; do
  echo "waiting for cluster $CLUSTER_NAME"
  sleep 10
done

echo "cluster $CLUSTER_NAME is healthy"
CMD_EOF

    environment = {
      CLUSTER_NAME           = module.master.eks_cluster.name
      CLUSTER_ENDPOINT       = module.master.eks_cluster.endpoint
      CLUSTER_TOKEN          = module.master.eks_cluster_auth.token
    }
  }

  # trigger everytime
  # triggers = {
  #   build_number = timestamp()
  # }

  depends_on = [module.master.eks_cluster]
}

resource "null_resource" "generate_kubeconfig" {
  count = var.generate_kubeconfig ? 1 : 0

  provisioner "local-exec" {
    command = <<CMD_EOF

# install aws-iam-authenticator
if [ -z $(which aws-iam-authenticator) ]; then
  curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator
  chmod +x ./aws-iam-authenticator && mv ./aws-iam-authenticator /usr/local/bin/
fi

cat <<EOF> $CLUSTER_NAME-kubeconfig.yaml
apiVersion: v1
preferences: {}
kind: Config

clusters:
- cluster:
    server: $CLUSTER_ENDPOINT
    certificate-authority-data: $CLUSTER_CA_CERTIFICATE
  name: $CLUSTER_NAME

contexts:
- context:
    cluster: $CLUSTER_NAME
    user: $CLUSTER_NAME
  name: $CLUSTER_NAME

current-context: $CLUSTER_NAME

users:
- name: $CLUSTER_NAME
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "k8s-cluster"
EOF

echo "file $CLUSTER_NAME-kubeconfig.yaml created"
CMD_EOF

    environment = {
      CLUSTER_NAME           = module.master.eks_cluster.name
      CLUSTER_ENDPOINT       = module.master.eks_cluster.endpoint
      CLUSTER_CA_CERTIFICATE = module.master.eks_cluster.certificate_authority.0.data
    }
  }

  # trigger everytime
  # triggers = {
  #   build_number = timestamp()
  # }

  depends_on = [null_resource.wait_cluster]
}

resource "local_file" "kubeconfig" {
  count = var.generate_kubeconfig ? 1 : 0

  content  = local.kubeconfig
  filename = local.kubeconfig_path

  depends_on = [null_resource.generate_kubeconfig]
}

locals {
  kubeconfig_path = format("%s/%s-kubeconfig.yaml", path.root, module.master.eks_cluster.name)
  kubeconfig = var.generate_kubeconfig ? (fileexists(local.kubeconfig_path) ? file(local.kubeconfig_path) : "") : ""
}
