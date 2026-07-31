resource "cloudflare_d1_database" "jobwatch" {
  account_id = local.account_id
  name       = "jobwatch"

  read_replication = {
    mode = "disabled"
  }

  lifecycle {
    prevent_destroy = true
  }
}
