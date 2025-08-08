variable "vpc_cidr" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "availability_zones" {}
variable "instance_type" {}
variable "key_name" {}

variable "github_token" {
  description = "GitHub Personal Access Token"
  default     = data.aws_ssm_parameter.github_token.value
}

variable "artifact_bucket_name" {
 
}

