output public_ip {
  value       = aws_instance.instancia.public_ip
}

output id {
  value       = aws_instance.instancia.id
}
