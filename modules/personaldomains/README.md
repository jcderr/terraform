# personal domains terraform

My goal here is to provide a list of domain names and S3 buckets, and have
Terraform set up everything necessary to host the site behind CloudFront using
a static S3 website as the origin.


## invocation

```
variable "domains" {
  type    = list(string)
  default = [
    "allcloudnocattle.com",
    "impulsiveventures.com",
  ]
}

variable "s3bucket" {
  type    = string
  default = "acnc-website"
}

module "personaldomains" {
  source  = "github.com/jcderr/terraform/modules/personaldomains.git?ref=v1.0.0"

  domains = var.domains
  bucket  = var.s3bucket
}
```
