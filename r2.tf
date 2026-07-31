resource "cloudflare_r2_bucket" "laundry_tokyo" {
  account_id = local.account_id
  name       = "laundry-tokyo"
  location   = "apac"

  lifecycle {
    prevent_destroy = true
  }
}
