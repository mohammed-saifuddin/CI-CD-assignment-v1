variable "github_token" {
  description = "GitHub Personal Access Token"
  default     = data.aws_ssm_parameter.github_token.value
}
variable "artifact_bucket_name" {
  description = "Name of the S3 bucket used for storing CodeBuild artifacts"
  type        = string
}
