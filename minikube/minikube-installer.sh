sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget apt-transport-https
sudo apt-get install docker.io -y
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo chmod 755 /usr/local/bin/minikube
minikube version
minikube start --driver=docker --force
sudo snap install kubectl --classic
# Verify node in minikube
kubectl get nodes
# Deploy nginx in minikube
kubectl apply -f nginx-deployment.yaml
# Verify pod created
kubectl get pods
kubectl port-forward --address 0.0.0.0 service/nginx-service 80:80

