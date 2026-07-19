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

resource "cloudflare_pages_project" "blog" {
  account_id        = local.account_id
  name              = "topazape" # topazape.pages.dev
  production_branch = "main"
}
