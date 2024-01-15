resource "vault_audit" "test" {
  type = "file"

  options = {
    file_path = "/tmp/vault/audit.log"
  }
}