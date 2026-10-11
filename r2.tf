resource "cloudflare_r2_bucket" "laundry_tokyo" {
  account_id = local.account_id
  name       = "laundry-tokyo"
  location   = "apac"

  lifecycle {
    prevent_destroy = true
  }
}

resource "cloudflare_r2_bucket_lifecycle" "laundry_tokyo" {
  account_id  = local.account_id
  bucket_name = cloudflare_r2_bucket.laundry_tokyo.name

  rules = [
    {
      id         = "expire-shop-backups-after-30-days"
      enabled    = true
      conditions = { prefix = "shop/" }

      delete_objects_transition = {
        condition = {
          type    = "Age"
          max_age = 2592000 # 30 days (sec)
        }
      }
    },
    {
      id         = "expire-status-backups-after-30-days"
      enabled    = true
      conditions = { prefix = "status/" }

      delete_objects_transition = {
        condition = {
          type    = "Age"
          max_age = 2592000 # 30 days (sec)
        }
      }
    },
    # Preserve R2's default rule to abort incomplete multipart uploads after 7 days.
    # This does not delete successfully uploaded objects.
    {
      id         = "abort-incomplete-multipart-uploads-after-7-days"
      enabled    = true
      conditions = { prefix = "" }

      abort_multipart_uploads_transition = {
        condition = {
          type    = "Age"
          max_age = 7 * 24 * 60 * 60
        }
      }
    }
  ]
}
