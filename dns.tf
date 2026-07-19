resource "cloudflare_dns_record" "apex_a_108" {
  zone_id = cloudflare_zone.this.id
  name    = "topazape.dev"
  type    = "A"
  content = "185.199.108.153"
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "apex_a_109" {
  zone_id = cloudflare_zone.this.id
  name    = "topazape.dev"
  type    = "A"
  content = "185.199.109.153"
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "apex_a_110" {
  zone_id = cloudflare_zone.this.id
  name    = "topazape.dev"
  type    = "A"
  content = "185.199.110.153"
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "apex_a_111" {
  zone_id = cloudflare_zone.this.id
  name    = "topazape.dev"
  type    = "A"
  content = "185.199.111.153"
  proxied = false
  ttl     = 1
}

# www CNAME to GitHub Pages
resource "cloudflare_dns_record" "www_cname" {
  zone_id = cloudflare_zone.this.id
  name    = "www.topazape.dev"
  type    = "CNAME"
  content = "topazape.github.io"
  proxied = false
  ttl     = 1

  settings = {
    flatten_cname = false
  }
}
