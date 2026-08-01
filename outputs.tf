output "jobwatch_d1_database_id" {
  value = cloudflare_d1_database.jobwatch.id
}

output "laundry_tokyo_kv_namespace_id" {
  value = cloudflare_workers_kv_namespace.laundry_tokyo.id
}

output "shop_ingest_url" {
  value = cloudflare_pipeline_stream.shop.endpoint
}
