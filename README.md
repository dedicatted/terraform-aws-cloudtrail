# Terraform Module: terraform-aws-cloudtrail
# This module facilitates the enabling CloudTrail with creation of encrypted S3 bucket for logs.

## Overview
The `terraform-aws-cloudtrail` module enables CloudTrail to capture all compatible management events in region. 

For capturing events from services like IAM, include_global_service_events must be enabled.

## Usage
```hcl
//Configuration for both email and Google chat webhook
module cloudtrail {
  source = "github.com/dedicatted/terraform-aws-cloudtrail"
}
```