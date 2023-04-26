resource "aws_instance" "instance_01" {
  ami           = var.ami_id_amazon_linux
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = var.ssh_vockey

  tags = {
    Name = "test-instance01"
  }
}

resource "aws_instance" "instance_02" {
  ami           = var.ami_id_amazon_linux
  instance_type = "t2.micro"
  availability_zone = "us-east-1b"
  key_name = var.ssh_vockey

  tags = {
    Name = "test-instance02"
  }
}