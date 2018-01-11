# basic makefile

BLUE	:= \033[0;34m
GREEN	:= \033[0;32m
RED   := \033[0;31m
NC    := \033[0m

# run all
all: prereqs plan apply provision
	@echo "${GREEN}✓ 'make all' has completed ${NC}\n"

prereqs: ; @scripts/getip

# initial terraform setup
init: ; @echo "${GREEN}✓ Initializing terraform ${NC}\n"
		@terraform get
	  	@terraform init
		@$(MAKE) -s post-action

# plan terraform
plan: ; @terraform plan --out out.terraform

# apply terraform
apply: ; @terraform apply out.terraform

# destroy all resources and amivar.tf file
destroy: ; @echo "${RED}✓ Destroying terraform resources ${NC}\n"
		   @terraform destroy -force
		   @-rm -f amivar.tf web.*
		   @$(MAKE) -s post-action

# run packer to build a custom image
packer: ; @echo "${GREEN}✓ Running packer${NC}\n"
		  @scripts/packer
		  @$(MAKE) -s post-action

provision: ; @echo "${GREEN}✓ Provisioning hosts with Ansible${NC}\n"
			 @scripts/ansible
			 @$(MAKE) -s post-action

# run post actions
post-action: ; @echo "${BLUE}✓ Done. ${NC}\n"

# make graph
graph: ; @terraform graph > web.dot
		 @dot web.dot -Tsvg -o web.svg

.PHONY: post-action
.PHONY: packer
.PHONY: destroy

# destroy all
d: destroy post-action