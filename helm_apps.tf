resource "null_resource" "deploy_helm_apps" {
  provisioner "local-exec" {
    command = <<CMD_EOF
# download and install kubectl
if [ -z $(which kubectl) ]; then
  curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.16.0/bin/linux/amd64/kubectl
  chmod +x ./kubectl && mv kubectl /usr/local/bin
fi

# download and install helm
if [ -z $(which helm) ]; then
  curl -LO https://get.helm.sh/helm-v3.2.0-linux-amd64.tar.gz
  tar -zxvf ./helm-v3.2.0-linux-amd64.tar.gz && \
    mv ./linux-amd64/helm /usr/local/bin/helm && \
    rm -rf ./linux-amd64/ && rm -f ./helm-v3.2.0-linux-amd64.tar.gz
fi


INGRESS_INSTALLED=$(helm ls --all -n ingress-nginx 2> /dev/null | grep -ic "deployed")
if [ $INGRESS_INSTALLED -eq 0 ]; then
  # add ingress controller repo and update repos
  helm repo add nginx-stable https://helm.nginx.com/stable
  echo "repo added"
  # install ingress controller
  helm install ingress-nginx \
    -n ingress-nginx \
    --set controller.name="ingress-nginx" \
    --set controller.kind=deployment \
    --set controller.service.name=ingress-nginx \
    nginx-stable/nginx-ingress
  echo "release installed"
fi
# check if ingress controller is up and running
while [ $(kubectl get pods -n ingress-nginx -l app=ingress-nginx | grep -ic "running") -eq 0 ]; do
  echo "waiting for ingress controller pod be running"
  sleep 10
done


CERT_MANAGER_INSTALLED=$(helm ls --all -n cert-manager 2> /dev/null | grep -ic "deployed")
if [ $CERT_MANAGER_INSTALLED -eq 0 ]; then
  # add cert-manager repo and update repos
  helm repo add jetstack https://charts.jetstack.io
  helm repo update

  helm install cert-manager \
    jetstack/cert-manager \
    --namespace cert-manager \
    --version v0.15.1 \
    --set installCRDs=true \
    --set 'extraArgs={--dns01-recursive-nameservers=8.8.8.8:53\,1.1.1.1:53}'
fi
# check if ingress controller is up and running
while [ $(kubectl get pods -n cert-manager -l app=cert-manager | grep -ic "running") -eq 0 ]; do
  echo "waiting for cert manager pod be running"
  sleep 10
done

CMD_EOF

    environment = {
      KUBECONFIG = local_file.kubeconfig.0.filename
    }
  }

  # trigger everytime
  # triggers = {
  #   build_number = timestamp()
  # }

  depends_on = [kubernetes_namespace.ingress-nginx-namespace, kubernetes_namespace.cert-manager-namespace]
}
