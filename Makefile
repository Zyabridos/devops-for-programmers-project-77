# ----------- Terraform -----------

init:
	@echo "🔧 Initializing Terraform..."
	cd terraform && terraform init

plan:
	@echo "📋 Planning Terraform changes..."
	cd terraform && terraform plan

apply:
	@echo "🚀 Applying Terraform changes..."
	cd terraform && terraform apply -auto-approve

destroy:
	@echo "💣 Destroying Terraform infrastructure..."
	cd terraform && terraform destroy -auto-approve

output:
	@echo "🔍 Showing Terraform outputs..."
	cd terraform && terraform output

fmt:
	@echo "🎨 Formatting Terraform files..."
	cd terraform && terraform fmt -recursive

validate:
	@echo "✅ Validating Terraform configuration..."
	cd terraform && terraform validate


# ----------- Ansible -----------

ping-web:
	@echo "📡 Pinging web servers..."
	cd ansible && ansible -i inventory.ini webservers -m ping

install-roles:
	@echo "📦 Installing Ansible Galaxy roles..."
	cd ansible && ansible-galaxy install -r requirements.yml

deploy:
	@echo "🚀 Running Ansible deployment..."
	cd ansible && ansible-playbook playbook.yml --tags deploy

playbook:
	@echo "🚀 Running Ansible entire Playbook..."
	cd ansible && ansible-playbook playbook.yml
