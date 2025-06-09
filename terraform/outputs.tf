output "webservers_ips" {
  value = aws_instance.web[*].public_ip
}

output "load_balancer_dns" {
  value = aws_lb.app_lb.dns_name
}

output "name_servers" {
  description = "NS records that must be set at the domain registrar"
  value       = aws_route53_zone.main.name_servers
}

output "cert_arn" {
  value = aws_acm_certificate.cert.arn
}
