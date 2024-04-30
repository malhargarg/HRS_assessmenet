variable "zone_name" {
  description = "The name of the Route 53 hosted zone."
}

variable "record_name" {
  description = "The name of the Route 53 record."
}

variable "ttl" {
  description = "The TTL (time to live) value for the Route 53 record."
  default     = "30"
}

variable "records" {
  description = "The name servers for the Route 53 record."
  type        = list(string)
  default = [ "ns-1536.awsdns-00.co.uk" ]
}

variable "tags" {
  description = "A map of tags to assign to the Route 53 hosted zone."
  type        = map(string)
}
