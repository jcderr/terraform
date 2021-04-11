resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = "${var.s3bucket["bucket_name"]}.s3-website-us-east-1.amazonaws.com"
    origin_id   = "S3-${var.s3bucket["bucket_name"]}"
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2",
      ]
    }
  }
  aliases = [
    var.domain,
    "www.${var.domain}",
  ]
  # By default, show index.html file
  default_root_object = "index.html"
  enabled             = true
  # If there is a 404, return index.html with a HTTP 200 Response
  custom_error_response {
    error_caching_min_ttl = 3000
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.s3bucket["bucket_name"]}"
    # Forward all query strings, cookies and headers
    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  # Distributes content to US and Europe
  price_class = "PriceClass_100"
  # Restricts who is able to access this content
  restrictions {
    geo_restriction {
      # type of restriction, blacklist, whitelist or none
      restriction_type = "none"
    }
  }
  # SSL certificate for the service.
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
    ssl_support_method  = "sni-only"
  }

  tags = {
    "site" = var.domain
  }

  logging_config {
    bucket          = var.logging_bucket
    include_cookies = var.log_cookies
    prefix          = var.logging_prefix
  }

  depends_on = [
    aws_acm_certificate.cert,
  ]
}
