# Shared Makefile for Terraform modules
# Source: praxis-terraform-modules/terraform-cicd-templates
# Do not edit directly — update in terraform-cicd-templates repo

.PHONY: fmt fmt-check docs docs-check validate lint security init pre-commit clean all ci test setup

# Local dev - auto-fixes
all: fmt docs validate lint

fmt:
	terraform fmt -recursive .

docs:
	terraform-docs markdown table --indent 2 --output-mode inject --output-file README.md .

# CI - check only, no auto-fix
ci: fmt-check init docs-check validate lint security test

fmt-check:
	terraform fmt -check -recursive .

docs-check:
	terraform-docs markdown table --indent 2 --output-mode inject --output-file README.md .
	git diff --exit-code README.md

validate: init
	terraform validate

init:
	terraform init -backend=false

lint:
	tflint --init
	tflint

security:
	checkov -d . --config-file .checkov.yml --quiet
	trivy config . --severity HIGH,CRITICAL --exit-code 1 --skip-dirs .terraform

pre-commit:
	pre-commit run --all-files

clean:
	rm -rf .terraform .terraform.lock.hcl

test: init
	@if [ -d tests ]; then terraform test; else echo "No tests/ directory, skipping."; fi

setup:
	pip install checkov
	brew install tflint terraform-docs trivy pre-commit 2>/dev/null || true
	terraform init -backend=false
	pre-commit install
	@echo "Setup complete. Run 'make all' to verify."

update:
	curl -sSLo .shared.mk https://raw.githubusercontent.com/praxis-terraform-modules/terraform-cicd-templates/main/shared.mk
	@echo "Shared Makefile updated."
