# metal-deployment-opa
Terraform deployment on Metal Cloud with Open Policy Agent example and Testing

## Table of Contents
- [Pre-requirement](#pre-requirements)
- [Usage](#usage)
- [Testing](#testing)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Pre-requirement


↥ [back to top](#table-of-contents)

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)
- [Open Policy Agent](https://www.openpolicyagent.org/)
- [serverspec](https://serverspec.org/)
- [Terraform](https://serverspec.org/)

## Usage

↥ [back to top](#table-of-contents)

This repository will provide an environment where you can deploy you infrastructure on [Equinix Metal](https://console.equinix.com/) using terraform in combination with open policy agent for compliance and test the deployed environment to see if it satisfy your needs.

deploy local virtual machine and login to it
```bash
vagrant up
vagrant ssh
cd /vagrant # change the directory to working one, with terraform code
```

create terraform plan and convert it to json
```bash
terraform init
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json
```

in the example we are requesting `t1.small.x86` plan
```bash
module "device" {
  source              = "git::github.com/andrewpopa/terraform-metal-device.git"
  hostname            = "metal-with-opa"
  plan                = "t1.small.x86"
  facilities          = ["ams1"]
  operating_system    = "ubuntu_18_04"
  billing_cycle       = "hourly"
  project_id          = var.project_id
  project_ssh_key_ids = [module.key.id]
  user_data           = data.template_file.user_data.rendered
}
```
machine which doesn't satisfy the condition of our policy with allowed types
```bash
allowed_types = [
  "c3.small.x86",
  "c3.medium.x86",
]
```
therefore during the evaluation the policy will give an error similar to this
```bash
vagrant@opa:/vagrant$ opa eval --fail --format pretty --input tfplan.json --data policy/ data.terraform.deny
[
  "Instance type t1.small.x86 not allowed."
]
```

## Testing

↥ [back to top](#table-of-contents)

Once the infrastructure configuration satisfied the policy condition and `terraform apply` finished. As result of terraform run it will create ssh config file which can be used for passwordless authentication for testing.

copying the config to `.ssh` directory
```bash
cp config /.ssh/
```

run the testing
```bash
rake spec
```
it should give similar output 

```bash
vagrant@opa:/vagrant$ rake spec
/usr/bin/ruby2.7 -I/var/lib/gems/2.7.0/gems/rspec-support-3.10.3/lib:/var/lib/gems/2.7.0/gems/rspec-core-3.10.1/lib /var/lib/gems/2.7.0/gems/rspec-core-3.10.1/exe/rspec --pattern spec/terraform.radacina.xyz/\*_spec.rb

Package "nginx"
  is expected to be installed

Port "80"
  is expected to be listening

Finished in 0.07756 seconds (files took 2.48 seconds to load)
2 examples, 0 failures
```

as it was expected - packages `nginx` is installed and port `80` is listening

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 3.0 |
| <a name="requirement_metal"></a> [metal](#requirement\_metal) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_device"></a> [device](#module\_device) | git::github.com/andrewpopa/terraform-metal-device.git | n/a |
| <a name="module_dns"></a> [dns](#module\_dns) | git::github.com/andrewpopa/terraform-cloudflare-dns | n/a |
| <a name="module_key"></a> [key](#module\_key) | git::github.com/andrewpopa/terraform-metal-project-ssh-key | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.test_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [template_file.this](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | project id | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_private_ipv4"></a> [access\_private\_ipv4](#output\_access\_private\_ipv4) | private ipv4 |
| <a name="output_access_public_ipv4"></a> [access\_public\_ipv4](#output\_access\_public\_ipv4) | public ipv4 |
| <a name="output_hostname"></a> [hostname](#output\_hostname) | hostname |
