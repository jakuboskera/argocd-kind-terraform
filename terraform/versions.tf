terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.0.13"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.6.0"
    }
  }
}
