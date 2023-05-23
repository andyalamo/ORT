resource "aws_vpc" "vpc" {
  cidr_block           = var.rango_ip_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name
  }
}

module "Subnet" {
    source = "./modulos/subnet"

    for_each = local.subnets

    vpc_id              = aws_vpc.vpc.id
    rango_ip            = each.value.rango_ip
    availability_zone   = each.value.availability_zone
    public_ip_on_launch = each.value.public_ip_on_launch
    subnet_name         = each.value.subnet_name

}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.rt_name
  }
}

module "routes_association" {
    source = "./modulos/rt_association"

    for_each = local.routes_association

    subnet_id       = each.value.subnet_id
    route_table_id  = aws_route_table.rt.id

}

resource "aws_db_subnet_group" "db_group" {
  name       = "db_group"
  subnet_ids = [module.Subnet["subnet_us_east_1a"].subnet_id, module.Subnet["subnet_us_east_1b"].subnet_id]

  tags = {
    Name = "My DB subnet group"
  }
}