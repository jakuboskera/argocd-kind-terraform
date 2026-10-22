terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.13.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "3.3.0"
    }
  }
}
