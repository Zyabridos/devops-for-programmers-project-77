output "webServersPublicIPs" {
  value = aws_instance.web[*].public_ip
}
