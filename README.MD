## terraform-aws-ec2-deploy
This is not a module, do not use for production.

### Purpose
This code is for testing Terraform creation of an ec2 instance using a spot request, which then calls a cloud-init config to configure a backup to S3 on a cron schedule.

### Resources created:
  - ec2_instance (spot request)
  - iam_role
  - iam_policy
  - s3_bucket
  - security_group

### Required inputs
  - ssh_pub_key
  - ssh_key_name
  - bucket_name
