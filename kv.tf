resource "cloudflare_workers_kv_namespace" "laundry_tokyo" {
  account_id = local.account_id
  title      = "laundry-tokyo"
}
