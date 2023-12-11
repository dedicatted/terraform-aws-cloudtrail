variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region to deploy."
}

variable "cloudtrail_name" {
  type        = string
  default     = "cloudtrail"
  description = "Name for the Cloudtrail."
}

variable "s3_bucket_name" {
  type        = string
  default     = "s3-cloudtrail-logs"
  description = "Name of the S3 bucket designated for publishing log files."
}

variable "include_global_service_events" {
  type        = bool
  default     = false
  description = "For capturing events from services like IAM, include_global_service_events must be enabled."
}

variable "force_destroy" {
  type        = bool
  default     = true
  description = "Allow deletion of non-empty bucket."
}

variable "s3_key_prefix" {
  type        = string
  default     = "cloudtrail"
  description = "S3 key prefix for CloudTrail logs"
}

variable "enabled_cloudtrail" {
  type        = bool
  default     = true
  description = "If true, deploy the resources for the module."
}
