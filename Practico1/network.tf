resource "aws_vpc" "practico-terraform-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "test-terraform-vpc"
  }
}

resource "aws_subnet" "practico-terraform-subnet" {
  vpc_id                  = aws_vpc.practico-terraform-vpc.id
  cidr_block              = var.private_subnet
  availability_zone       = var.vpc_aws_az
  map_public_ip_on_launch = "true"
  tags = {
    Name = "test-terraform-subnet"
  }
}



resource "aws_internet_gateway" "practico-terraform-igw" {
  vpc_id = aws_vpc.practico-terraform-vpc.id

  tags = {
    Name = "test-terraform-ig"
  }
}



resource "aws_route_table" "practico-terraform-rt" {
  vpc_id = aws_vpc.practico-terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.practico-terraform-igw.id
  }

  tags = {
    Name = "test-terraform-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.practico-terraform-subnet.id
  route_table_id = aws_route_table.practico-terraform-rt.id
}