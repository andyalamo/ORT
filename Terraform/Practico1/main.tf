resource "aws_instance" "test-terraform-ec2" {
  ami           = "${var.ami_id_amazon_linux}"
  instance_type = var.instance_type_t2
  availability_zone = var.availability_zone_a1
  subnet_id     = aws_subnet.practico-terraform-subnet.id
  key_name = var.ssh_vockey
  vpc_security_group_ids = [aws_security_group.practico-terraform-sg.id]

  tags = {
    Name = "test-instance01"
  }
}


resource "aws_instance" "test-terraform-ec2-web01" {
  ami           = "${var.ami_id_amazon_linux}"
  instance_type = var.instance_type_t2
  availability_zone = var.availability_zone_a1
  subnet_id     = aws_subnet.practico-terraform-subnet.id
  key_name = var.ssh_vockey
  vpc_security_group_ids = [aws_security_group.practico-terraform-sg.id]


  connection {
    type     = "ssh"
    user     = "ec2-user"
    host     = aws_instance.test-terraform-ec2-web01.public_ip
    private_key = file("./vockey.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd git -y",
      "sudo systemctl enable --now httpd",
      "sudo git -C /var/www/html clone https://github.com/mauricioamendola/chaos-monkey-app.git"
    ]
  }

  tags = {
    Name = "ec2-instance-web01"
  }
}