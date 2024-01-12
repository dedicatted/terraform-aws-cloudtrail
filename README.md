# Terraform Module: terraform-aws-cloudtrail
This module facilitates the enabling CloudTrail with creation of encrypted S3 bucket for logs.

## Overview
The `terraform-aws-cloudtrail` module enables CloudTrail to capture all compatible management events in region.

For capturing events from services like IAM, include_global_service_events must be enabled.

## Usage
```hcl
module cloudtrail {
  source = "github.com/dedicatted/terraform-aws-cloudtrail"
}
```
### To add AWS Organizations trail
```
module cloudtrail {
  source = "github.com/dedicatted/terraform-aws-cloudtrail"
  is_organization_trail = true
}
```

### To add multi region trail
```
module cloudtrail {
  source = "github.com/dedicatted/terraform-aws-cloudtrail"
  is_multi_region_trail = true
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.30.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_cloudwatch_log_group.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.cloudtrail_cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.cloudtrail_cloudwatch_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_kms_alias.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cloudtrail_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudtrail_cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_watch_logs_group_arn"></a> [cloud\_watch\_logs\_group\_arn](#input\_cloud\_watch\_logs\_group\_arn) | Specifies a log group name using an Amazon Resource Name (ARN), that represents the log group to which CloudTrail logs will be delivered. | `string` | `""` | no |
| <a name="input_cloud_watch_logs_role_arn"></a> [cloud\_watch\_logs\_role\_arn](#input\_cloud\_watch\_logs\_role\_arn) | Specifies the role for the CloudWatch Logs endpoint to assume to write to a user’s log group. | `string` | `""` | no |
| <a name="input_cloudtrail_name"></a> [cloudtrail\_name](#input\_cloudtrail\_name) | Name for the Cloudtrail. | `string` | `"cloudtrail"` | no |
| <a name="input_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#input\_cloudwatch\_log\_group\_name) | The name of the CloudWatch Log Group that receives CloudTrail events. | `string` | `"cloudtrail-events"` | no |
| <a name="input_enable_cloudwatch"></a> [enable\_cloudwatch](#input\_enable\_cloudwatch) | If true, deploy the resources for cloudwatch in the module. | `bool` | `true` | no |
| <a name="input_enable_log_file_validation"></a> [enable\_log\_file\_validation](#input\_enable\_log\_file\_validation) | Specifies whether log file integrity validation is enabled. Creates signed digest for validated contents of logs. | `bool` | `true` | no |
| <a name="input_enabled_cloudtrail"></a> [enabled\_cloudtrail](#input\_enabled\_cloudtrail) | If true, deploy the resources for the module. | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Allow deletion of non-empty bucket. | `bool` | `true` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Name for the CloudTrail IAM role | `string` | `"cloudtrail-cloudwatch-logs-role"` | no |
| <a name="input_include_global_service_events"></a> [include\_global\_service\_events](#input\_include\_global\_service\_events) | For capturing events from services like IAM, include\_global\_service\_events must be enabled. | `bool` | `false` | no |
| <a name="input_is_multi_region_trail"></a> [is\_multi\_region\_trail](#input\_is\_multi\_region\_trail) | Specifies whether the trail is created in the current region or in all regions | `bool` | `false` | no |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | The trail is an AWS Organizations trail. | `bool` | `false` | no |
| <a name="input_key_deletion_window_in_days"></a> [key\_deletion\_window\_in\_days](#input\_key\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource, must be 7-30 days.  Default 30 days. | `string` | `30` | no |
| <a name="input_kms_enabled"></a> [kms\_enabled](#input\_kms\_enabled) | If true, deploy the resources for kms in the module. Note: Supports in only single cloudtrail management. | `bool` | `true` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | Number of days to keep AWS logs around in specific log group. | `string` | `90` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region to deploy. | `string` | `"us-east-1"` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | Name of the S3 bucket designated for publishing log files. | `string` | `"s3-cloudtrail-logs"` | no |
| <a name="input_s3_key_prefix"></a> [s3\_key\_prefix](#input\_s3\_key\_prefix) | S3 key prefix for CloudTrail logs | `string` | `"cloudtrail"` | no |
| <a name="input_sns_topic_name"></a> [sns\_topic\_name](#input\_sns\_topic\_name) | Specifies the name of the Amazon SNS topic defined for notification of log file delivery. | `string` | `null` | no |

## Outputs

No outputs.
