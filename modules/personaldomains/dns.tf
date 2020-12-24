resource "aws_route53_zone" "zone" {

  name = var.domain
  tags = {
    "site" = var.domain
  }
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = replace(aws_cloudfront_distribution.distribution.domain_name, "/[.]$/", "")
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = true
  }

  depends_on = [
    aws_cloudfront_distribution.distribution,
    aws_route53_zone.zone
  ]
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = "www"
  type    = "CNAME"
  ttl     = 300
  records = [
    var.domain,
  ]

  depends_on = [aws_route53_record.root]
}
