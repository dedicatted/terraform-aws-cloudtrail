# Terraform Module: terraform-aws-cloudtrail

## Overview
The `terraform-aws-cloudtrail` module enables CloudTrail to capture all compatible management events in region. 

## Usage
```hcl
//Configuration for both email and Google chat webhook
module cloudtrail {
  source = "github.com/dedicatted/terraform-aws-cloudtrail"
}
```