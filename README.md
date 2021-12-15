# metal-deployment-opa
Terraform deployment on Metal Cloud with OPA

# Run OPA web UI

```bash
opa run -a 0.0.0.0:8181 -s plan.rego
```


# Plan evaluation

```bash
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json
opa eval --fail-defined --format pretty --input tfplan.json --data policy/ data.terraform.deny
```