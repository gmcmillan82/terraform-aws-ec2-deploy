output "ip_address" {
  value = aws_instance.test_instance.public_ip
}
