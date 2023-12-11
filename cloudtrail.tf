resource "aws_cloudtrail" "cloudtrail" {

  count = var.enabled_cloudtrail == true ? 1 : 0

  name                          = var.cloudtrail_name
  s3_bucket_name                = aws_s3_bucket.example.id
  s3_key_prefix                 = var.s3_key_prefix
  include_global_service_events = var.include_global_service_events


  # enable_log_file_validation    = var.enable_log_file_validation
  # is_multi_region_trail         = var.is_multi_region_trail
  # cloud_watch_logs_role_arn     = var.cloud_watch_logs_role_arn
  # cloud_watch_logs_group_arn    = var.cloud_watch_logs_group_arn
  # kms_key_id                    = join("", aws_kms_key.cloudtrail[*].arn)
  # is_organization_trail         = var.is_organization_trail
  # tags                          = module.labels.tags
  # sns_topic_name                = var.sns_topic_name


  depends_on = [aws_s3_bucket_policy.example]
}

resource "aws_s3_bucket" "example" {
  bucket        = var.s3_bucket_name
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.example.id
  policy = data.aws_iam_policy_document.example.json
}
