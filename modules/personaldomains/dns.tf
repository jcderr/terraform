# Route53 Zones

resource "aws_route53_zone" "zones" {
  for_each = var.domains

  name = each.value
  tags = {
    "site" = each.value
  }
}

# resource "aws_route53_record" "iv_root" {
#   zone_id = aws_route53_zone.iv.zone_id
#   name    = var.domain_list["primary"]
#   type    = "A"
#
#   alias {
#     name                   = replace(aws_cloudfront_distribution.prod_distribution.domain_name, "/[.]$/", "")
#     zone_id                = aws_cloudfront_distribution.prod_distribution.hosted_zone_id
#     evaluate_target_health = true
#   }
#
#   depends_on = [
#     aws_cloudfront_distribution.prod_distribution,
#     aws_route53_zone.iv
#   ]
# }
#
# resource "aws_route53_record" "iv_www" {
#   zone_id = aws_route53_zone.iv.zone_id
#   name    = "www"
#   type    = "CNAME"
#   ttl     = 300
#   records = [
#     var.domain_list["primary"],
#   ]
#
#   depends_on = [aws_route53_record.iv_root]
# }
#
# resource "aws_route53_record" "root" {
#   zone_id = aws_route53_zone.eremy_nl.zone_id
#   name    = "${var.host_name}.${var.domain_name}"
#   type    = "A"
#
#   alias {
#     name                   = replace(aws_cloudfront_distribution.prod_distribution.domain_name, "/[.]$/", "")
#     zone_id                = aws_cloudfront_distribution.prod_distribution.hosted_zone_id
#     evaluate_target_health = true
#   }
#
#   depends_on = [aws_cloudfront_distribution.prod_distribution]
# }
