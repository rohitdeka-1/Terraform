# Outputting a list of strings
output "instance_ids" {
  description = "The IDs of the created instances"
  value       = aws_instance.web[*].id
}

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
