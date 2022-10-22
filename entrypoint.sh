#!/bin/sh

set -xe

echo "$KUBE_CONFIG" | base64 -d > /tmp/kube_config
export KUBECONFIG=/tmp/kube_config

if [ -z ${KUBECTL_VERSION} ] ; then
    echo "Using kubectl version: $(kubectl version --client --short)"
else
    echo "Installing kubection version: $KUBECTL_VERSION"
    rm /usr/bin/kubectl
    curl -sL -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/"$KUBECTL_VERSION"/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl
fi

sh -c "$*"
