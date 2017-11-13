BLUE	:= \033[0;34m
GREEN	:= \033[0;32m
RED   := \033[0;31m
NC    := \033[0m

all: prereqs init apply
	@echo "${GREEN}✓ terraform portion of 'make all' has completed ${NC}\n"
	@$(MAKE) -s post-terraform

prereqs: ; @scripts/getip

init: ; @scripts/init

apply: ; @scripts/apply

packer: ; @scripts/packer

post-terraform:
	@echo "DONE."

.PHONY: post-terraform
.PHONY: packer 

