resource "cloudflare_dns_record" "apex" {
  zone_id = cloudflare_zone.this.id
  name    = "topazape.dev"
  type    = "CNAME"
  content = "topazape.pages.dev"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "www" {
  zone_id = cloudflare_zone.this.id
  name    = "www.topazape.dev"
  type    = "CNAME"
  content = "topazape.pages.dev"
  proxied = true
  ttl     = 1
}
