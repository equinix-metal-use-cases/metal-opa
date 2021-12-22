module "dns" {
  source = "git::github.com/andrewpopa/terraform-cloudflare-dns"

  email      = "andrew.popa@gmail.com"
  api_key    = ""
  account_id = ""
  zone_id    = ""
  name       = "terraform"
  value      = module.device.access_public_ipv4
  type       = "A"
  ttl        = "3600"

  // additional
  domain = "radacina.xyz"
}