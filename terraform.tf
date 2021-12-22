terraform {
  required_providers {
    metal = {
      source  = "equinix/metal"
      version = "~> 3.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}