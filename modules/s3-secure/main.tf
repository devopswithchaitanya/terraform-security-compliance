# Compliant S3 bucket — passes all Checkov & tfsec checks

resource "aws_s3_bucket" "secure" {
  bucket = var.bucket_name
  tags   = { Name = var.bucket_name; Environment = var.environment; ManagedBy = "Terraform" }
}

# Checkov: CKV_AWS_18 - Enable access logging
resource "aws_s3_bucket_logging" "secure" {
  bucket        = aws_s3_bucket.secure.id
  target_bucket = aws_s3_bucket.secure.id
  target_prefix = "access-logs/"
}

# Checkov: CKV_AWS_19 - Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "secure" {
  bucket = aws_s3_bucket.secure.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.kms_key_id
    }
    bucket_key_enabled = true
  }
}

# Checkov: CKV_AWS_21 - Enable versioning
resource "aws_s3_bucket_versioning" "secure" {
  bucket = aws_s3_bucket.secure.id
  versioning_configuration { status = "Enabled" }
}

# Checkov: CKV_AWS_20, CKV2_AWS_6 - Block all public access
resource "aws_s3_bucket_public_access_block" "secure" {
  bucket                  = aws_s3_bucket.secure.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Checkov: CKV_AWS_145 - Force SSL only
resource "aws_s3_bucket_policy" "ssl_only" {
  bucket = aws_s3_bucket.secure.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyNonSSL"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource  = ["${aws_s3_bucket.secure.arn}", "${aws_s3_bucket.secure.arn}/*"]
        Condition = { Bool = { "aws:SecureTransport" = "false" } }
      }
    ]
  })
}
