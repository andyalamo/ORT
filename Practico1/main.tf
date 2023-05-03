resource "aws_instance" "test-terraform-ec2" {
  ami           = var.ami_id_amazon_linux
  instance_type = var.instance_type_t2
  availability_zone = var.availability_zone_a1
  subnet_id     = aws_subnet.practico-terraform-subnet.id
  key_name = var.ssh_vockey
  vpc_security_group_ids = [aws_security_group.practico-terraform-sg.id]

  tags = {
    Name = "test-instance01"
  }
}