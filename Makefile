# basic makefile

BLUE	:= \033[0;34m
GREEN	:= \033[0;32m
RED   := \033[0;31m
NC    := \033[0m

# run all
all: plan apply provision
	@echo "${GREEN}✓ 'make all' has completed ${NC}\n"

# initial terraform setup
init: ; @echo "${GREEN}✓ Initializing terraform ${NC}\n"
	@cd terraform && terraform get && terraform init
	@$(MAKE) -s post-action

# plan terraform
plan: ; @echo "${GREEN}✓ Planning terraform ${NC}\n"
	@cd terraform && terraform plan --out out.terraform
	@$(MAKE) -s post-action

# apply terraform
apply: ; @echo "${GREEN}✓ Applying terraform ${NC}\n"
	@cd terraform && terraform apply out.terraform
	@$(MAKE) -s post-action

# destroy all resources and amivar.tf file
destroy: ; @echo "${RED}✓ Destroying terraform resources ${NC}\n"
	@cd terraform && terraform destroy -force
	@-rm -f amivar.tf web.* ansible/*.retry
	@$(MAKE) -s post-action
.PHONY: destroy

# run packer to build a custom image
packer: ; @echo "${GREEN}✓ Running packer${NC}\n"
	@scripts/packer
	@$(MAKE) -s post-action
.PHONY: packer

provision: ; @echo "${GREEN}✓ Provisioning hosts with Ansible${NC}\n"
	@scripts/ansible
	@$(MAKE) -s post-action

# run post actions
post-action: ; @echo "${BLUE}✓ Done. ${NC}\n"
.PHONY: post-action

# make graph
graph: ; @terraform graph > web.dot
	@dot web.dot -Tsvg -o web.svg

getip: ; @scripts/getip

# destroy all
d: destroy post-action