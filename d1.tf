resource "cloudflare_d1_database" "jobwatch" {
  account_id = local.account_id
  name       = "jobwatch"

  lifecycle {
    prevent_destroy = true
  }
}

output "jobwatch_d1_database_id" {
  value = cloudflare_d1_database.jobwatch.id
}
