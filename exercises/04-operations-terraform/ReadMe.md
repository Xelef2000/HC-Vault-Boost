Vault Provisioning with Terraform
===

In this exercise we will provision the primary Vault cluster using Terraform. We will use the [Vault Terraform Provider](https://www.terraform.io/docs/providers/vault/index.html) to provision the cluster.
Go to `enviroment/Provisioning` and configure the `terraform.tfvars` file with
your values(see `terraform.tfvars.example`). Then configure the vault cluster
with the given terraform configuration.

## Additional Configuration

The Terraform code applies the following configuration:

- Add a new namespace for a new customer
- Create add a new policy for the new namespace
- Create a new token for the new namespace
- Create a KV secret engine for the new namespace
- Create a new secret in the new KV secret engine
- enable a new auth method for the new namespace
- Create a new role for the new auth method
