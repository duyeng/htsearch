#!/bin/sh

env=${1:-}

if [[ "$env" == "dev" ]]; then
    echo "Deploy to local dev"
    docker-compose run api rails db:setup
    docker-compose up
fi

if [[ "$env" == "prod" ]]; then
    aws eks update-kubeconfig --name ${AWS_EKS_CLUSTER_NAME} --region ${AWS_REGION}

#    kubectl create secret docker-registry regcred \
#      --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com \
#      --docker-username=AWS \
#      --docker-password=$(aws ecr get-login-password)

    echo "Deploy mysql"
    kubectl apply -f ./k8s/pv.yaml
    kustomize build ./k8s/mysql | kubectl apply -f -
    echo "Deploy redis"
    kustomize build ./k8s/redis | kubectl apply -f -
    echo "Deploy api"
    kustomize build ./k8s/api | kubectl apply -f -
    echo "Deploy worker"
    kustomize build ./k8s/worker | kubectl apply -f -
fi

