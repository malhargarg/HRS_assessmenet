resource "aws_vpc" "hrs_vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "hrs_subnet" {
  vpc_id            = aws_vpc.hrs_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone
}

resource "aws_internet_gateway" "hrs_igw" {
  vpc_id = aws_vpc.hrs_vpc.id
}

resource "aws_vpc_attachment" "hrs_attachment" {
  vpc_id             = aws_vpc.hrs_vpc.id
  internet_gateway_id = aws_internet_gateway.hrs_igw.id
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.hrs_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hrs_igw.id
  }
}

resource "aws_route_table_association" "my_route_association" {
  subnet_id      = aws_subnet.hrs_subnet.id
  route_table_id = aws_route_table.hrs_route_table.id
}

resource "aws_ecs_cluster" "my_cluster" {
  name = var.cluster_name
}
