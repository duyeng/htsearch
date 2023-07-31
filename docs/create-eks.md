### Push image to AWS ECR
```
# Docker login
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 502479798840.dkr.ecr.us-east-2.amazonaws.com
# Docker build
docker build -t hs-app .
# Add tage
docker tag hs-app:latest 502479798840.dkr.ecr.us-east-2.amazonaws.com/hs-app:latest
# Push image
docker push 502479798840.dkr.ecr.us-east-2.amazonaws.com/hs-app:latest
```

### Create AWS EKS
```
# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
which aws
sudo ./aws/install --bin-dir /usr/bin --install-dir /usr/bin/aws-cli --update
# Add access key
aws configure

# Install EKS CTL
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/bin

# Create cluster
eksctl create cluster --name dev --version 1.27 --region us-east-2 --nodegroup-name standard-workers --node-type t3.medium --nodes 3 --nodes-min 1 --nodes-max 4 --managed
aws eks update-kubeconfig --name dev --region us-east-2

# Add more nodegroup
eksctl create nodegroup --cluster dev --max-pods-per-node 20

# Create docker-registry secret
kubectl create secret docker-registry regcred \
--docker-server=502479798840.dkr.ecr.us-east-2.amazonaws.com \
--docker-username=AWS \
--docker-password=$(aws ecr get-login-password)
```
