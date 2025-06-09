output "web_servers_ips" {
  value = aws_instance.web[*].public_ip
}

output "db_name" {
  value = aws_db_instance.db.db_name
}

output "load_balancer_dns" {
  value = aws_lb.app_lb.dns_name
}

output "name_servers" {
  description = "NS records that must be set at the domain registrar"
  value       = aws_route53_zone.main.name_servers
}
