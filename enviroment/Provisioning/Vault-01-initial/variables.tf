variable "VAULT_TOKEN" {
  type        = string
  description = "Vault token"
}

variable "VAULT_ADDR"{
    type = string
    default = "https://vault-primary.vault-boost.lab/"
    description = "Vault address"
}

variable "kubecontext" {
  type = string
}

variable "kubeconfig" {
  type = string
}
