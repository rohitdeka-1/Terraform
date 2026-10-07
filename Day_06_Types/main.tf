# This file will use the different variables to create resources.

resource "aws_instance" "web" {
  # Using number
  count = var.instance_count

  # Using string from object
  ami           = var.server_config.ami_id
  instance_type = var.server_config.instance_type

  # Using list
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))

  # Using boolean
  monitoring = var.enable_monitoring

  root_block_device {
    # Using number from object
    volume_size = var.server_config.volume_size
  }

  # Using map and locals
  tags = merge(local.merged_tags, {
    Name = "${local.name_prefix}-Instance-${count.index + 1}"
  })
}
resource "aws_s3_bucket" "app_data" {
  # Using a local variable (which itself uses var.common_tags) to name the bucket
  # We also use the lower() function as bucket names must be lowercase
  bucket = lower("${local.name_prefix}-app-data")

  # Applying the merged tags from locals
  tags = local.merged_tags
}

