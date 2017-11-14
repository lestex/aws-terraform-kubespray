BLUE	:= \033[0;34m
GREEN	:= \033[0;32m
RED   := \033[0;31m
NC    := \033[0m

all: prereqs plan
	@echo "${GREEN}✓ 'make all' has completed ${NC}\n"
	@$(MAKE) -s post-terraform

prereqs: ; @scripts/getip

init: ; @echo "${GREEN}✓ initializing terraform ${NC}\n"
		@terraform get
	  	@terraform init
		@$(MAKE) -s post-terraform

plan: ; @terraform plan --out out.terraform

apply: ; @terraform apply out.terraform

delete: ; @terraform destroy -force

packer: ; @scripts/packer

post-terraform:	; @echo "${BLUE}✓ DONE. ${NC}\n"

.PHONY: post-terraform
.PHONY: packer
.PHONY: destroy

destroy: delete post-terraform