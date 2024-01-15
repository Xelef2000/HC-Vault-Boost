resource "vault_mount" "cs1-kvv2" {
  path        = "kvv2"
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}


resource "time_sleep" "cs1-kv-wait_3_seconds" {
  depends_on = [vault_mount.cs1-kvv2]

  create_duration = "3s"
}

resource "vault_kv_secret_backend_v2" "cs1-kvv2-1" {
  depends_on           = [time_sleep.cs1-kv-wait_3_seconds]
  mount                = vault_mount.cs1-kvv2.path
  max_versions         = 5
  delete_version_after = 12600 #3h
}

