.ONESHELL:
.SHELL := /bin/bash
.DEFAULT_GOAL := help

.PHONY: help pre-commit-install pre-commit-all tf-apply tf-destroy argocd-get-password argocd-port-forward guestbook-port-forward

help:
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

pre-commit-install: ## Install pre-commit into your git hooks. After that pre-commit will now run on every commit
	pre-commit install

pre-commit-all: ## Manually run all pre-commit hooks on a repository (all files)
	pre-commit run --all-files

tf-init: ## Make terraform init
	terraform -chdir=terraform init

tf-apply: tf-init ## Creates infrastructure based on terraform/main.tf using terraform
	terraform -chdir=terraform apply -auto-approve

tf-destroy: ## Destroys infrastructure based on terraform/main.tf using terraform
	terraform -chdir=terraform apply -destroy -auto-approve

argocd-get-password: ## Gets initial password of argocd installation, username is admin
	kubectl --kubeconfig terraform/my-cluster-config -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

argocd-port-forward: ## Port-forward to argocd application, it will be then accessible on http://localhost:8080
	kubectl --kubeconfig terraform/my-cluster-config -n argocd port-forward svc/argocd-server 8080:80

guestbook-port-forward: ## Port-forward to guestbook application, it will be then accessible on http://localhost:5000
	kubectl --kubeconfig terraform/my-cluster-config -n guestbook port-forward svc/guestbook 5000:80

# New targets here
