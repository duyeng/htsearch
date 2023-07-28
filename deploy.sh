#!/bin/sh

set -euo pipefail

env=${1:-}

if [[ "$env" == "dev" ]]; then
    echo "Deploy to local dev"

    kubectl apply -f ./k8s/redis/

    kubectl apply -f ./k8s/mysql/

    kubectl scale statefulsets mysql --replicas=1

    docker build -t hs-api:latest -f Dockerfile .
fi
