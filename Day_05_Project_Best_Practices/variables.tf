variable "environment" {
  type        = string
  description = "The target deploy environment"
  default     = "dev"
}


variable "app_name" {
  type    = string
  default = "web-api"
}
