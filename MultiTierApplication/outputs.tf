output "website_url" {
  description = "The URL of the Web Application"
  value       = "http://${module.compute.alb_dns_name}"
}
