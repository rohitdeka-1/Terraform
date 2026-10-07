# Outputting a list of bucket names from the count resource
output "app_data_buckets" {
  description = "The names of the app data buckets created"
  value       = aws_s3_bucket.app_data[*].bucket
}

# When you use count (like you did for aws_s3_bucket.app_data), Terraform returns a list of resources. Lists can be accessed using the "splat" operator [*] to grab an attribute from every item in the list (e.g., aws_s3_bucket.app_data[*].bucket).

output "web_data_buckets" {
  value = [for b in aws_s3_bucket.web_data : b.bucket]
}

# When you use for_each (like you did for aws_s3_bucket.web_data), Terraform returns a map (key-value pairs) of resources. You cannot use the splat operator on a map.


# Outputting an object
output "server_configuration_used" {
  description = "The server configuration that was applied"
  value       = var.server_config
}

# Outputting specific elements from a map
output "environment_tag" {
  description = "The environment tag used"
  value       = var.common_tags["Environment"]
}

# Outputting a boolean
output "monitoring_enabled" {
  description = "Whether detailed monitoring was enabled"
  value       = var.enable_monitoring
}



