data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}


resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.main-vpc.id
  map_public_ip_on_launch = true
  count                   = length(var.public_subnets)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = var.public_subnets[count.index]
  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}


resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.main-vpc.id
  count             = length(var.private_subnets)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = var.private_subnets[count.index]
  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "main-igw"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public-RouteTable"
  }
}


resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}



resource "aws_eip" "nat" {
  domain = "vpc"
}

//Private Subnet needs NAT and NAT gatewat needs a static Public IP to connect to the internet 

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet[0].id

  tags = {
    Name = "main-nat-gw"
  }

  depends_on = [aws_internet_gateway.gw]
}
//Create the NAT Gateway We put this inside our first Public Subnet (count.index == 0).


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Private-RouteTable"
  }
}


resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
