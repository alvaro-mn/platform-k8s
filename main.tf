terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  type      = string
  sensitive = true
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "platform-k8s" {
  name         = "platform-k8s"
  region       = "ams3"
  version      = "1.25.4-do.0"
  auto_upgrade = true

  # This default node pool is mandatory
  node_pool {
    name       = "default-pool"
    size       = "s-1vcpu-2gb" # minimum size, list available options with `doctl compute size list`
    auto_scale = false
    node_count = 1
  }

}
