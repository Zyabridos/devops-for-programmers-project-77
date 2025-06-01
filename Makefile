init:
	cd terraform && terraform init

plan:
	cd terraform && terraform plan

apply:
	cd terraform && terraform apply -auto-approve

destroy:
	cd terraform && terraform destroy -auto-approve

output:
	cd terraform && terraform output

fmt:
	cd terraform && terraform fmt -recursive

validate:
	cd terraform && terraform validate
