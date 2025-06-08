
# Terraform Web App Infrastructure

This project provisions infrastructure for a web application using **Terraform** and configures it using **Ansible**.  
It deploys [**my chat application**](https://github.com/Zyabridos/chat), containerized with **Docker** and hosted on EC2 instances behind a Load Balancer.

## What It Deploys

-   2 EC2 web servers (Ubuntu)
-   Docker + application container [zyabridos/chat:latest](https://hub.docker.com/repository/docker/zyabridos/chat/general)
-   HTTPS Load Balancer (Application Load Balancer)
-   PostgreSQL database (RDS)
-   Elastic IPs for each server
-   Security groups with ports 22, 80, 443
-   Fully automated provisioning and deployment pipeline
    
## Prerequesties

-   **Terraform** >= 1.3
-   **AWS CLI** configured with necessary permissions
-   **Make**
-   **Ansible** >= 2.15
-   SSH key (`~/.ssh/new_key` and `~/.ssh/new_key.pub`) for EC2 access

## Deployed Application
You can access the application here:
🔗 [https://ansible-container-orchestrator.online/](https://ansible-container-orchestrator.online/)
The domain is connected to an AWS Application Load Balancer with HTTPS enabled via ACM.

    

## Usage

### 1. Initialize & Plan Infrastructure

```bash
make init
make plan
```

### 2. Apply Infrastructure

```bash
make apply
```

### 3. Deploy Application via Ansible
```bash
make install-roles
make deploy
```

### 4. Destroy Infrastructure
```bash 
make destroy
```
## 🛠 Useful Commands

```bash
make init          # Initialize Terraform
make apply         # Apply infrastructure changes
make destroy       # Destroy all resources
make output        # Show output values (e.g. LB URL)
make validate      # Validate Terraform files
make fmt           # Format Terraform files
make ping-web      # Ping web servers using Ansible
make install-roles # Install Ansible Galaxy roles
make deploy        # Deploy application with Ansible
make playbook      # Run Ansible`s main playbook
```

## Project Structure

```bash
terraform/ # Infrastructure as code (EC2, ALB, RDS, SGs, etc.) 
ansible/   # Configuration management (Docker, app container)
Makefile   # Automation commands`
```