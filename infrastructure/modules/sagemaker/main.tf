data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id  = data.aws_caller_identity.current.account_id
  region_code = data.aws_region.current.name
}

resource "aws_s3_bucket" "main" {
  bucket = var.s3_bucket_name

  tags = merge(var.tags, {
    Name = var.s3_bucket_name
  })
}

resource "aws_iam_role" "main" {
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:ListBucket"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.main.id}"
            ]
        },
        {
            "Action": [
                "s3:GetObject"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.main.id}*"
            ]
        },
        {
            "Action": [
                "logs:CreateLogStream",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:CreateLogGroup"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:${local.region_code}:${local.account_id}:log-group:/aws/sagemaker/*",
                "arn:aws:logs:${local.region_code}:${local.account_id}:log-group:/aws/sagemaker/*:log-stream:aws-glue-*"
            ]
        },
        {
            "Action": [
                "glue:UpdateDevEndpoint",
                "glue:GetDevEndpoint",
                "glue:GetDevEndpoints"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:glue:${local.region_code}:${local.account_id}:devEndpoint/*"
            ]
        },
        {
            "Action": [
                "sagemaker:ListTags"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:sagemaker:${local.region_code}:${local.account_id}:notebook-instance/*"
            ]
         }
    ]
}
EOF
}

resource "aws_sagemaker_code_repository" "main" {
  code_repository_name = var.repository_name

  git_config {
    repository_url = var.repository_url
  }
}

resource "aws_sagemaker_notebook_instance" "main" {
  name                    = var.notebook_instance_name
  role_arn                = aws_iam_role.main.arn
  instance_type           = var.instance_type
  default_code_repository = aws_sagemaker_code_repository.main.code_repository_name
  lifecycle_config_name   = "./on_start.sh"

  tags = merge(var.tags, {
    Name   = var.notebook_instance_name
    BUCKET = aws_s3_bucket.main.id
  })
}
