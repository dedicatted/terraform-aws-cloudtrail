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

variable "enable_log_file_validation" {
  type        = bool
  default     = true
  description = "Specifies whether log file integrity validation is enabled. Creates signed digest for validated contents of logs."
}

variable "is_multi_region_trail" {
  type        = bool
  default     = false
  description = "Specifies whether the trail is created in the current region or in all regions"
}

variable "cloud_watch_logs_role_arn" {
  type        = string
  default     = ""
  description = "Specifies the role for the CloudWatch Logs endpoint to assume to write to a user’s log group."
  sensitive   = true
}

variable "cloud_watch_logs_group_arn" {
  type        = string
  default     = ""
  description = "Specifies a log group name using an Amazon Resource Name (ARN), that represents the log group to which CloudTrail logs will be delivered."
  sensitive   = true
}

variable "is_organization_trail" {
  type        = bool
  default     = false
  description = "The trail is an AWS Organizations trail."
}

variable "sns_topic_name" {
  type        = string
  default     = null
  description = "Specifies the name of the Amazon SNS topic defined for notification of log file delivery."
}

variable "enable_cloudwatch" {
  type        = bool
  default     = true
  description = "If true, deploy the resources for cloudwatch in the module."
}

variable "iam_role_name" {
  type        = string
  default     = "cloudtrail-cloudwatch-logs-role"
  description = "Name for the CloudTrail IAM role"
}

variable "cloudwatch_log_group_name" {
  type        = string
  default     = "cloudtrail-events"
  description = "The name of the CloudWatch Log Group that receives CloudTrail events."
}

variable "log_retention_days" {
  type        = string
  default     = 90
  description = "Number of days to keep AWS logs around in specific log group."
}

variable "kms_enabled" {
  type        = bool
  default     = true
  description = "If true, deploy the resources for kms in the module. Note: Supports in only single cloudtrail management."
}

variable "key_deletion_window_in_days" {
  type        = string
  default     = 30
  description = "Duration in days after which the key is deleted after destruction of the resource, must be 7-30 days.  Default 30 days."
}
