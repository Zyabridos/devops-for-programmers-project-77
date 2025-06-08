output "web_ips" {
  value = [
    aws_eip.web_1.public_ip,
    aws_eip.web_2.public_ip,
  ]
}

output "load_balancer_dns" {
  value = aws_lb.app_lb.dns_name
}

output "name_servers" {
  description = "NS records that must be set at the domain registrar"
  value       = aws_route53_zone.main.name_servers
}
