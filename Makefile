TFPLAN = .tfplan

init:
	cd terraform && terraform init

workspaces: init
	cd terraform && terraform workspace new $(ENV) || true

plan: workspaces
	cd terraform && terraform workspace select $(ENV)
	cd terraform && terraform plan -out $(TFPLAN)
	cd terraform && terraform show $(TFPLAN)

deploy: plan
	cd terraform && terraform workspace select $(ENV)
	cd terraform && terraform apply -auto-approve $(TFPLAN)

clean: init
	cd terraform && terraform workspace select $(ENV)
	cd terraform && terraform destroy -auto-approve
	rm $(TFPLAN) || true
