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
    cors           = {}
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

  format = { type = "parquet" }
  schema = { fields = [] }

  config = {
    account_id     = local.account_id
    bucket         = cloudflare_r2_bucket.laundry_tokyo.name
    namespace      = "laundry"
    table_name     = "shop"
    token          = var.laundry_tokyo_catalog_token
    rolling_policy = { interval_seconds = 300 }
  }

  depends_on = [
    cloudflare_r2_data_catalog.laundry_tokyo
  ]
}

resource "cloudflare_pipeline" "shop" {
  account_id = local.account_id
  name       = "laundry_tokyo_shop"
  sql        = "INSERT INTO laundry_tokyo_shop_sink SELECT * FROM laundry_tokyo_shop;"

  lifecycle {
    replace_triggered_by = [
      cloudflare_pipeline_stream.shop.id
    ]
  }

  depends_on = [
    cloudflare_pipeline_stream.shop,
    cloudflare_pipeline_sink.shop
  ]
}

resource "cloudflare_pipeline_stream" "status" {
  account_id = local.account_id
  name       = "laundry_tokyo_status"

  http = {
    enabled        = true
    authentication = true
    cors           = {}
  }
  worker_binding = { enabled = false }

  format = { type = "json" }

  schema = {
    fields = [
      { name = "shop_id", type = "string", required = true },
      { name = "machine_id", type = "string", required = true },
      { name = "machine_kind", type = "string", required = false },
      { name = "status", type = "string", required = true },
      { name = "status_code", type = "string", required = false },
      { name = "remaining_minutes", type = "string", required = false },
      { name = "course_code", type = "string", required = false },
      { name = "reported_at", type = "timestamp", required = false },
      { name = "fetched_at", type = "timestamp", required = true }
    ]
  }
}

resource "cloudflare_pipeline_sink" "status" {
  account_id = local.account_id
  name       = "laundry_tokyo_status_sink"
  type       = "r2_data_catalog"

  format = {
    type        = "parquet",
    compression = "zstd"
  }
  schema = { fields = [] }

  config = {
    account_id     = local.account_id
    bucket         = cloudflare_r2_bucket.laundry_tokyo.name
    namespace      = "laundry"
    table_name     = "status"
    token          = var.laundry_tokyo_catalog_token
    rolling_policy = { interval_seconds = 300 }
  }

  depends_on = [
    cloudflare_r2_data_catalog.laundry_tokyo,
  ]
}

resource "cloudflare_pipeline" "status" {
  account_id = local.account_id
  name       = "laundry_tokyo_status"
  sql        = "INSERT INTO laundry_tokyo_status_sink SELECT * FROM laundry_tokyo_status;"

  lifecycle {
    replace_triggered_by = [
      cloudflare_pipeline_stream.status.id
    ]
  }

  depends_on = [
    cloudflare_pipeline_stream.status,
    cloudflare_pipeline_sink.status
  ]
}
