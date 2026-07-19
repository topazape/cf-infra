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

resource "cloudflare_pages_domain" "apex" {
  account_id   = local.account_id
  project_name = cloudflare_pages_project.blog.name
  name         = "topazape.dev"
}

resource "cloudflare_pages_domain" "www" {
  account_id   = local.account_id
  project_name = cloudflare_pages_project.blog.name
  name         = "www.topazape.dev"
}
