
resource "aws_s3_bucket" "app_data" {
  count  = 2
  bucket = lower(var.bucket_names[count.index])
}

resource "aws_s3_bucket" "web_data" {
  for_each = var.web_bucket
  bucket   = lower(each.value)

  tags = {
    Name = each.value
  }
}
