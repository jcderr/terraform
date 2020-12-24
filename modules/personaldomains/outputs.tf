output nameservers {
  value = aws_route53_zone.zone.name_servers
}

output zone_id {
  value = aws_route53_zone.zone.zone_id
}

output distribution_id {
  value = aws_cloudfront_distribution.distribution.id
}
