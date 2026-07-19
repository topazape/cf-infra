provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_zone" "this" {
  account = {
    id = local.account_id
  }

  name                = "topazape.dev"
  paused              = false
  type                = "full"
  vanity_name_servers = []
}
