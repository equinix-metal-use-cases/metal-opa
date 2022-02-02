resource "random_pet" "this" {
  length = 3
}

data "template_file" "this" {
  template = file("${path.module}/templates/config.tpl")
  vars = {
    hostname  = module.dns.hostname
    cert_name = module.key.private_key_filename
  }
}

resource "local_file" "test_config" {
  content         = data.template_file.this.rendered
  filename        = "config"
  file_permission = "0600"
}