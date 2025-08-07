variable "vpc_cidr" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "availability_zones" {}
variable "instance_type" {}
variable "key_name" {}

# variable "github_oauth_token" {
#   description = "GitHub OAuth token to connect CodePipeline with GitHub"
#   type        = string
#   sensitive   = true
# }
variable "artifact_bucket_name" {
 
}

