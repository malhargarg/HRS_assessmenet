resource "aws_vpc" "hrs_vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "hrs_subnet" {
  vpc_id            = aws_vpc.hrs_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone
}