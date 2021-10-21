#!/bin/bash
set -e

# delete cluster & registry
k3d cluster delete devops-test
k3d registry delete registry.localhost

# remove registry adress from /etc/hosts
grep -n k3d-registry.localhost /etc/hosts | cut -f1 -d: | xargs -I {} sh -c "sudo sed -i.bak '{}d' /etc/hosts"

echo "Successfully deleted devops-test cluster!"