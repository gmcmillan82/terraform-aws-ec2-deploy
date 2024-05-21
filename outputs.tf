output "ip_address" {
  value = aws_instance.test_instance.public_ip
}

output "user_data" {
  value = aws_instance.test_instance.user_data
}
