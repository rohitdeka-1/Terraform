locals {
  # We can merge tags or manipulate data here
  merged_tags = merge(var.common_tags, {
    ManagedBy = "Terraform"
    Monitoring = tostring(var.enable_monitoring)
  })

  # Accessing list elements
  primary_az = var.availability_zones[0]

  # Creating a string from variables
  name_prefix = "${var.common_tags["Project"]}-${var.common_tags["Environment"]}"
}
