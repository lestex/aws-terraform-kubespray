BLUE	:= \033[0;34m
GREEN	:= \033[0;32m
RED   := \033[0;31m
NC    := \033[0m

all: prereqs plan
	@echo "${GREEN}✓ 'make all' has completed ${NC}\n"
	@$(MAKE) -s post-action

prereqs: ; @scripts/getip

init: ; @echo "${GREEN}✓ initializing terraform ${NC}\n"
		@terraform get
	  	@terraform init
		@$(MAKE) -s post-action

plan: ; @terraform plan --out out.terraform

apply: ; @terraform apply out.terraform

destroy: ; @echo "${RED}✓ destroying terraform resources ${NC}\n"
		   @terraform destroy -force
		   @-rm -f amivar.tf

packer: ; @scripts/packer

post-action:	; @echo "${BLUE}✓ DONE. ${NC}\n"

.PHONY: post-action
.PHONY: packer
.PHONY: destroy

d: destroy post-action