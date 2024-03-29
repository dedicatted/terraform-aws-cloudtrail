resource "aws_cloudtrail" "cloudtrail" {
  count                         = var.enabled_cloudtrail ? 1 : 0
  name                          = var.cloudtrail_name
  s3_bucket_name                = aws_s3_bucket.cloudtrail.id
  s3_key_prefix                 = var.s3_key_prefix
  include_global_service_events = var.include_global_service_events
  enable_log_file_validation    = var.enable_log_file_validation
  is_multi_region_trail         = var.is_multi_region_trail
  is_organization_trail         = var.is_organization_trail
  kms_key_id                    = join("", aws_kms_key.cloudtrail[*].arn)

  depends_on = [
    aws_s3_bucket_policy.cloudtrail,
    aws_kms_key.cloudtrail,
    aws_kms_alias.cloudtrail,
  ]
}

# S3 bucket creation and it's policy.
## ==============================================================================================

resource "aws_s3_bucket" "cloudtrail" {
  bucket        = "${var.s3_bucket_name}-${var.cloudtrail_name}-${random_string.suffix.result}"
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = ["s3:GetBucketAcl", "s3:ListBucket"],
        Effect = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com",
        },
        Resource = [aws_s3_bucket.cloudtrail.arn],
      },
      {
        Action = "s3:PutObject",
        Effect = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com",
        },
        Resource = [format("%s/*", aws_s3_bucket.cloudtrail.arn)],
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control",
          },
        },
      },
    ],
  })
}


## ==============================================================================================
## Customer managed key.
## Supports only for single account cloudtrail.
## ==============================================================================================

resource "aws_kms_key" "cloudtrail" {
  count                   = var.kms_enabled && var.enabled_cloudtrail ? 1 : 0
  description             = "A KMS key used to encrypt CloudTrail log files stored in S3."
  deletion_window_in_days = var.key_deletion_window_in_days
  enable_key_rotation     = "true"
  policy                  = data.aws_iam_policy_document.kms.json
}

resource "aws_kms_alias" "cloudtrail" {
  name          = "alias/${var.cloudtrail_name}"
  target_key_id = aws_kms_key.cloudtrail[0].key_id
}

data "aws_iam_policy_document" "kms" {
  version = "2012-10-17"
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
  statement {
    sid    = "Allow CloudTrail to encrypt logs"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["kms:GenerateDataKey*"]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"]
    }
  }

  statement {
    sid    = "Allow CloudTrail to describe key"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["kms:DescribeKey"]
    resources = ["*"]
  }

  statement {
    sid    = "Allow principals in the account to decrypt log files"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"]
    }
  }

  statement {
    sid    = "Allow alias creation during setup"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["kms:CreateAlias"]
    resources = ["*"]
  }
}
