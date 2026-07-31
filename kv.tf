resource "cloudflare_workers_kv_namespace" "laundry_tokyo" {
  account_id = local.account_id
  title      = "laundry-tokyo"
}

output "laundry_tokyo_kv_namespace_id" {
  value = cloudflare_workers_kv_namespace.laundry_tokyo.id
}
