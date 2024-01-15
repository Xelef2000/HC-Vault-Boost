resource "vault_policy" "example" {
  name = "dev-team"

  policy = <<EOT
path "/kvv2/*" {
  capabilities = ["read", "list", "create", "update", "delete"]
}
EOT
}