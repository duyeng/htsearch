aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 502479798840.dkr.ecr.us-east-2.amazonaws.com

docker build -t hs-app .

docker tag hs-app:latest 502479798840.dkr.ecr.us-east-2.amazonaws.com/hs-app:latest

docker push 502479798840.dkr.ecr.us-east-2.amazonaws.com/hs-app:latest


aws iam create-role --role-name myAmazonEKSClusterRole --assume-role-policy-document file://"eks-cluster-role-trust-policy.json"

aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy --role-name myAmazonEKSClusterRole


aws cloudformation create-stack \
--region us-east-2 \
--stack-name ror-eks-vpc-stack \
--template-url https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/amazon-eks-vpc-private-subnets.yaml

aws iam create-role \
--role-name rorAmazonEKSClusterRole \
--assume-role-policy-document file://"eks-cluster-role-trust-policy.json"

aws iam attach-role-policy \
--policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy \
--role-name rorAmazonEKSClusterRole


aws eks update-kubeconfig --region us-east-2 --name aks-rails-app

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
which aws
sudo ./aws/install --bin-dir /usr/bin --install-dir /usr/bin/aws-cli --update
aws configure
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/bin


eksctl create cluster --name dev --version 1.27 --region us-east-2 --nodegroup-name standard-workers --node-type t3.micro --nodes 3 --nodes-min 1 --nodes-max 4 --managed

aws eks update-kubeconfig --name dev --region us-east-2