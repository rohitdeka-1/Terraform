variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block of the VPC for security group ingress"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "db_name" {
  type    = string
  default = "myappdb"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_instance_type" {
  type    = string
  default = "db.t3.micro"
}
