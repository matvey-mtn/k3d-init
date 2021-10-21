#!/bin/bash
set -e

REGISTRY_PORT=5555

# create registry that will be used by k3s cluster
k3d registry create registry.localhost --port $REGISTRY_PORT

# add registry address to /etc/hosts to enable push via docker push command
sudo -- sh -c "echo '127.0.0.1  k3d-registry.localhost' >> /etc/hosts"

# create k3s cluster named devops-test with 1 server (master) and 1 agent (worker)
# configure cluster to use previously created registry
k3d cluster create devops-test --agents 1 \
--registry-use k3d-registry.localhost:$REGISTRY_PORT \
--kubeconfig-switch-context

echo "Successfully created devops-test cluster!"