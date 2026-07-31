resource "cloudflare_r2_data_catalog" "laundry_tokyo" {
  account_id  = local.account_id
  bucket_name = cloudflare_r2_bucket.laundry_tokyo.name
}

resource "cloudflare_pipeline_stream" "shop" {
  account_id = local.account_id
  name       = "laundry_tokyo_shop"

  http = {
    enabled        = true
    authentication = true
  }
  worker_binding = { enabled = false }

  format = { type = "json" }

  schema = {
    fields = [
      { name = "shop_id", type = "string", required = true },
      { name = "name", type = "string", required = true },
      { name = "name_kana", type = "string", required = false },
      { name = "pref", type = "string", required = false },
      { name = "city", type = "string", required = false },
      { name = "address", type = "string", required = false },
      { name = "postal", type = "string", required = false },
      { name = "lat", type = "float64", required = false },
      { name = "lng", type = "float64", required = false },
      { name = "is_iot_enabled", type = "bool", required = true },
      { name = "facilities", type = "json", required = false },
      { name = "business_hours", type = "string", required = false },
      { name = "closed_days", type = "string", required = false },
      { name = "fetched_at", type = "timestamp", required = true }
    ]
  }
}

resource "cloudflare_pipeline_sink" "shop" {
  account_id = local.account_id
  name       = "laundry_tokyo_shop_sink"
  type       = "r2_data_catalog"

  config = {
    account_id     = local.account_id
    bucket         = cloudflare_r2_bucket.laundry_tokyo.name
    namespace      = "laundry"
    table_name     = "shop"
    token          = var.laundry_tokyo_catalog_token
    rolling_policy = { interval_seconds = 300 }
  }
}

resource "cloudflare_pipeline" "shop" {
  account_id = local.account_id
  name       = "laundry_tokyo_shop"
  sql        = "INSERT INTO laundry_tokyo_shop_sink SELECT * FROM laundry_tokyo_shop;"
}
