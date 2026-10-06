locals {
  #Dynamically generated nnaming conventions
  resource_prefix = "${var.environment}-${var.app_name}"

  common_tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }

}

# Consuming the local in your resources
# resource "aws_instance" "server" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t3.micro"

#   tags = merge(
#     local.common_tags,
#     { Name = "${local.resource_prefix}-ec2" }
#   )
# }
