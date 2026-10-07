# String data type

variable "bucket_names" {
  description = "List of buckets to be created"
  type        = list(string)
  default     = ["ap-south-1-bucket-one", "ap-south-1-bucket-two"]
}

variable "web_bucket" {
  type    = set(string)
  default = ["ap-south-1-web-bucket-one", "ap-south-1-web-bucket-two"]
}

variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "ap-south-1"
}

# Number data type
variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2
}

# Boolean data type
variable "enable_monitoring" {
  description = "Enable detailed monitoring on instances"
  type        = bool
  default     = true
}

# List data type (ordered, elements must be same type)
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

# Map data type (key-value pairs, values must be same type)
variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Dev"
    Project     = "LearningTerraform"
  }
}

# Object data type (complex structure with different types)
variable "server_config" {
  description = "Configuration for the server"
  type = object({
    ami_id        = string
    instance_type = string
    volume_size   = number
  })
  default = {
    ami_id        = "ami-0c2af51e265bd5e0e" # example Ubuntu AMI in ap-south-1
    instance_type = "t2.micro"
    volume_size   = 20
  }
}

# Tuple data type (ordered list of specific types)
variable "custom_ports" {
  description = "Custom ports to open (HTTP, custom)"
  type        = tuple([number, number])
  default     = [80, 8080]
}
