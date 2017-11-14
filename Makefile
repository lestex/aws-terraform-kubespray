# basic makefile

BLUE	:= \033[0;34m
GREEN	:= \033[0;32m
RED   := \033[0;31m
NC    := \033[0m

# run all
all: prereqs plan
	@echo "${GREEN}✓ 'make all' has completed ${NC}\n"
	@$(MAKE) -s post-action

prereqs: ; @scripts/getip

# initial terraform setup
init: ; @echo "${GREEN}✓ initializing terraform ${NC}\n"
		@terraform get
	  	@terraform init
		@$(MAKE) -s post-action

# plan terraform
plan: ; @terraform plan --out out.terraform

# apply terraform
apply: ; @terraform apply out.terraform

# destroy all resources and amivar.tf file
destroy: ; @echo "${RED}✓ destroying terraform resources ${NC}\n"
		   @terraform destroy -force
		   @-rm -f amivar.tf

# run packer to build a custom image
packer: ; @scripts/packer

# run post actions
post-action:	; @echo "${BLUE}✓ DONE. ${NC}\n"

.PHONY: post-action
.PHONY: packer
.PHONY: destroy

# destroy all
d: destroy post-action