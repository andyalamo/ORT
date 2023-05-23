output "public_ip_web" {
  value = aws_instance.test-terraform-ec2-web01.public_ip
}