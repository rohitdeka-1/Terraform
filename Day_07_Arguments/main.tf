
resource "aws_s3_bucket" "app_data" {
  count = 2
  bucket = lower(var.bucket_names[count.index])
}
 