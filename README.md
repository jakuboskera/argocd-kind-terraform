# argocd-kind-terraform

This repository shows how to use [Terraform](https://www.terraform.io) and
[Argo CD](https://argo-cd.readthedocs.io/en/stable) to create and manage
a Kubernetes cluster on [kind](https://kind.sigs.k8s.io).

It also deploy basic application [Guestbook](https://github.com/jakuboskera/guestbook).

## 📖 TOC

- [argocd-kind-terraform](#argocd-kind-terraform)
  - [📖 TOC](#-toc)
  - [⚠️ Prerequisites](#️-prerequisites)
  - [🏁 Get started](#-get-started)
    - [🚀 Create an infrastructure](#-create-an-infrastructure)
      - [Get initial argocd password for user `admin`](#get-initial-argocd-password-for-user-admin)
      - [Access to Argo CD](#access-to-argo-cd)
      - [Access to Guestbook](#access-to-guestbook)
    - [🧹 Destroy an infrastructure](#-destroy-an-infrastructure)

## ⚠️ Prerequisites

1. Docker installed
1. Terraform CLI installed
1. Kubectl CLI installed

## 🏁 Get started

1. Clone this repo

    ```bash
    git clone https://github.com/jakuboskera/argocd-kind-terraform.git
    ```

1. Navigate to a folder `argocd-kind-terraform`

    ```bash
    cd argocd-kind-terraform
    ```

1. Issue `make` command to see available targets, which you can use

    ```bash
    make
    ```

### 🚀 Create an infrastructure

To create an infrastructure based on `terraform/main.tf`

```bash
make tf-apply
```

After some minutes (max 5) it creates:

1. 1-node K8s cluster
1. running Argo CD
1. running basic application Guestbook

#### Get initial argocd password for user `admin`

```bash
make argocd-get-password
```

#### Access to Argo CD

T port-forward to argocd app, it will be available on <http://localhost:8080>

```bash
make argocd-port-forward
```

#### Access to Guestbook

To port-forward to guestbook app, it will be available on <http://localhost:5000>

```bash
make guestbook-port-forward
```

### 🧹 Destroy an infrastructure

To destroy infrastructure based on `terraform/main.tf`

```bash
make tf-destroy
```
