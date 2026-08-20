resource "cloudflare_email_routing_settings" "this" {
  zone_id = cloudflare_zone.this.id
}

resource "cloudflare_email_routing_address" "me" {
  account_id = local.account_id
  email      = var.email_routing_destination
}
