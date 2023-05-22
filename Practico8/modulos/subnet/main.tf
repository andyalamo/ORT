resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.rango_ip
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = var.public_ip_on_launch
  tags = {
    Name = var.subnet_name
  }
}