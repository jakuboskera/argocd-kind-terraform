terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.5.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.14.1"
    }
  }
}

provider "kind" {}

provider "helm" {
  kubernetes {
    host                   = kind_cluster.my-cluster.endpoint
    cluster_ca_certificate = kind_cluster.my-cluster.cluster_ca_certificate
    client_certificate     = kind_cluster.my-cluster.client_certificate
    client_key             = kind_cluster.my-cluster.client_key
  }
}

resource "kind_cluster" "my-cluster" {
  name           = "my-cluster"
  wait_for_ready = "true"
  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role  = "control-plane"
      image = "kindest/node:v1.30.2"
    }
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "7.4.1"
  wait             = true
  create_namespace = true
}

resource "helm_release" "argocd-apps" {
  name             = "argocd-apps"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-apps"
  namespace        = "argocd"
  version          = "2.0.0"

  values = [
    file("../argocd/application.yaml")
  ]

  depends_on = [ helm_release.argocd ]
}
