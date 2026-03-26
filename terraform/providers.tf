provider "kind" {}

provider "helm" {
  kubernetes = {
    host                   = kind_cluster.my-cluster.endpoint
    cluster_ca_certificate = kind_cluster.my-cluster.cluster_ca_certificate
    client_certificate     = kind_cluster.my-cluster.client_certificate
    client_key             = kind_cluster.my-cluster.client_key
  }
}
