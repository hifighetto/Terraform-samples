resource "aws_s3_bucket" "s3-hosted01" {
  bucket = "${var.project_name}-site"
  acl    = "public-read"

  versioning {
    enabled = "true"
  }
  policy = templatefile("site-policy.json", { project_name = "${var.project_name}-site" })

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = var.standard_tags
}