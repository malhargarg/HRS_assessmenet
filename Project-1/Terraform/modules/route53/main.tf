resource "aws_route53_zone" "main" {
  name = var.zone_name

  tags = var.tags
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.record_name
  type    = "NS"
  ttl     = var.ttl
  records = var.records
}
