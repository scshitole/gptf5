
output "bigip_public_ip" {
  value = "https://${aws_instance.bigip_instance.public_ip}:8443"
}

output "bigip_username" {
  value = "admin"
}

output "bigip_password" {
  value = random_string.password.result
}