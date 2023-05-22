resource "aws_instance" "instancia" {
  ami                       = var.ami
  instance_type             = var.instance_type
  availability_zone         = var.availability_zone
  subnet_id                 = var.subnet_id
  key_name                  = var.key_pair_name
  vpc_security_group_ids    = var.vpc_security_group_ids

  connection {
    type        = var.connection_type
    user        = var.username
    host        = aws_instance.instancia.public_ip
    private_key = file(var.private_key_file_location)
  }

  provisioner "remote-exec" {
    inline      = var.inline_commands
  }

  tags = {
    Name        = var.instance_name
  }
}