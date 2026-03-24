terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.11.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }
}
