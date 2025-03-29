provider "aws" {
  # Configuration options
  region = "${var.region}"
  profile = "${var.profile}"
}

resource "aws_resourcegroups_group" "group_tf" {
  name = "${var.group_tf_storage}"
  description = "Group for Terraform resources storage"
  resource_query {
    query = jsonencode({
      ResourceTypeFilters = ["AWS::S3::Bucket"]
      TagFilters = [{
        Key    = "Stage"
        Values = ["storage"] 
      }]
    })
    type = "TAG_FILTERS_1_0"
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.name_s3_bucket}"

  tags = {
    Stage = "storage"
    Name = "${var.name_s3_bucket}"
  }
}

resource "aws_s3_bucket_public_access_block" "allow_access_from_internet" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}

resource "aws_s3_bucket_policy" "allow_access_from_internet" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_internet.json
}

data "aws_iam_policy_document" "allow_access_from_internet" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.s3_bucket.arn,
      "${aws_s3_bucket.s3_bucket.arn}/*",
    ]
  }
}

locals {
  archivos = fileset("${var.ruta_local}", "**")
}

resource "aws_s3_object" "archivos" {
  for_each = local.archivos

  bucket = aws_s3_bucket.s3_bucket.id
  key    = each.value
  source = "${var.ruta_local}${each.value}"
  etag   = filemd5("${var.ruta_local}${each.value}") # MD5 hash of the file
}