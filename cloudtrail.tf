resource "aws_cloudtrail" "cloudtrail" {
  name                          = var.cloudtrail_name
  s3_bucket_name                = aws_s3_bucket.example.id
  s3_key_prefix                 = var.s3_key_prefix
  include_global_service_events = var.include_global_service_events

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
