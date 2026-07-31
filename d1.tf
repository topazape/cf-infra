resource "cloudflare_d1_database" "jobwatch" {
  account_id = local.account_id
  name       = "jobwatch"

  # スナップショットデータを持つため、誤った destroy/replace を防ぐ
  lifecycle {
    prevent_destroy = true
  }
}

# wrangler.jsonc の database_id に転記する
output "jobwatch_d1_database_id" {
  value = cloudflare_d1_database.jobwatch.id
}
