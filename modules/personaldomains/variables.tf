variable "domain" {
  type    = string
}

variable "s3bucket" {
  type    = map
}

variable logging_bucket {
  type = string
}

variable logging_prefix {
  type = string
}

variable log_cookies {
  type = bool
  default = false
}