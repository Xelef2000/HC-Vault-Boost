variable "VAULT_TOKEN" {
  type        = string
  description = "Vault token"
}

variable "VAULT_ADDR"{
    type = string
    default = "https://vault-tr-00.vault-boost.lab/"
    description = "Vault address"
}