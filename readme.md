# 🚀 Portfolio Deployment Using Terraform, Ansible, Docker, Jenkins, Kubernetes & Ingress (on EC2)

This project demonstrates a full DevOps lifecycle deployment of a portfolio website using an EC2 instance (not EKS). It covers provisioning with Terraform, configuration with Ansible, CI/CD via Jenkins, containerization with Docker, orchestration using Kubernetes, and clean URL routing with NGINX Ingress.

---

## 📁 Project Structure

```
.
├── Dockerfile
├── Jenkinsfile
├── terraform/
│   ├── main.tf
│   └── variables.tf
├── ansible/
│   └── provision.yml
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
```

---

## 🛠️ Tools & Technologies

| Layer         | Tool                            |
|---------------|----------------------------------|
| Infrastructure| Terraform (for EC2 provisioning) |
| Provisioning  | Ansible                          |
| CI/CD         | Jenkins + DockerHub              |
| Container     | Docker                           |
| Orchestration | Kubernetes (via kubeadm)         |
| CNI           | Flannel (installed via Ansible)  |
| Routing       | NGINX Ingress                    |

---

## ✅ Step-by-Step Workflow

### 1. 🚀 Launch EC2 via Terraform
```bash
cd terraform/
terraform init
terraform apply -auto-approve
```

### 2. ⚙️ Provision EC2 via Ansible
Install Docker, Kubernetes (kubeadm, kubelet, kubectl), Git, and configure the master node including Flannel CNI:
```bash
cd ansible/
ansible-playbook provision.yml -i inventory
```

### 3. 🔁 Configure Kubernetes Access
```bash
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
```

### 4. 📦 Clone Your Repository
```bash
sudo yum install git -y
git clone https://github.com/<your-username>/<your-repo>.git
cd <your-repo>
```

### 5. 🧪 Build and Push Docker Image (via Jenkins Pipeline)
Your Jenkinsfile should:
- Clone this repo
- Build the image
- Push to DockerHub (`rahul0941/portfolio-page`)

### 6. 🧱 Deploy to Kubernetes
```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

### 7. 🌐 Setup NGINX Ingress
```bash
kubectl create namespace ingress-nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.1/deploy/static/provider/cloud/deploy.yaml
kubectl taint nodes --all node-role.kubernetes.io/control-plane- || true
```

### 8. 🔗 Apply Ingress
```bash
kubectl apply -f k8s/ingress.yaml
kubectl get ingress
```

### 9. 🌍 Access the App
Find EC2 IP:
```bash
curl ifconfig.me
```
Then open in browser:
```
http://<EC2_PUBLIC_IP>/
```

---


## 🙌 Author

**Rahul Singh**  
DevOps Engineer | Frontend Developer

---

## 📌 Notes

- EC2 ensures website is always available
- Ingress eliminates the need to use NodePort access
- Flannel CNI installed using Ansible (not manual YAML)

