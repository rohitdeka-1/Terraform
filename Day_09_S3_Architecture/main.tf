
resource "aws_s3_bucket" "firstBucket" {
  bucket = var.bucket_names

}


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.firstBucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudfront_origin_access_control" "aoac" {
  name                              = "CloudFrontAccessControl"
  description                       = "CloudFrontAccessControl"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}



resource "aws_s3_bucket_policy" "allow_access_from_cloudfront" {
  bucket = aws_s3_bucket.firstBucket.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Statement1",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com"
        },
        "Action" : "s3:GetObject",
        "Resource" : "${aws_s3_bucket.firstBucket.arn}/*",
        "Condition" : {
          "StringEquals" : {
            "AWS:SourceArn" : aws_cloudfront_distribution.cdn.arn
          }
        }
      }
    ]
  })
}

# Upload Static Files
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.firstBucket.id
  key          = "index.html"
  source       = "www/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "style" {
  bucket       = aws_s3_bucket.firstBucket.id
  key          = "style.css"
  source       = "www/style.css"
  content_type = "text/css"
}

resource "aws_s3_object" "script" {
  bucket       = aws_s3_bucket.firstBucket.id
  key          = "script.js"
  source       = "www/script.js"
  content_type = "application/javascript"
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  origin {
    domain_name              = aws_s3_bucket.firstBucket.bucket_regional_domain_name
    origin_id                = "myS3Origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.aoac.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myS3Origin"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

