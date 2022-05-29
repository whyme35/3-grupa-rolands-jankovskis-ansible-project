variable "region" {
  description = "The region to launch the bastion host"
}
variable "vpc-cidr" {
  description = "The CIDR to assign to VPC"
}

variable "additional_tags" {
  default     = {}
  description = "Additional resource tags"
  type        = map(string)
}
variable "env" {
  description = "The Deployment environment"
}
variable "public_subnets_cidr" {
  type        = list
  description = "VPC public subnets"
}

variable "availability_zones" {
  type        = list
  description = "AWS availabity zones"
}
variable "instance_type" {
  description = "The NGINX EC2 instance type"
}
