#!/bin/bash
set -e

docker pull hello-world:latest
docker tag hello-world:latest k3d-registry.localhost:5555/hello-world:latest
docker push k3d-registry.localhost:5555/hello-world:latest

kubectl run --image k3d-registry.localhost:5555/hello-world:latest hello-world
sleep 3
TEST_OUTPUT=$(kubectl logs hello-world | grep Hello)
kubectl delete pod hello-world

EXPECTED="Hello from Docker!"

if [ "$TEST_OUTPUT" == "$EXPECTED" ]; then
    echo "Test Passed!"
else
    echo "Test Failed"
    echo "expected: $EXPECTED"
    echo "actual: $TEST_OUTPUT"
    exit 1
fi
