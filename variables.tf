variable "f5ami" {
  description = "f5 ami in west 2"
  default     = "ami-0a1e7d6045016baa5"
}
variable "prefix" {
  default = "scs"

}

variable "sub-region" {
  description = "region where the infra is deployed"
  default     = "us-west-2a"
}
