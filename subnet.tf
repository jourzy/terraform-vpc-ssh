resource "aws_subnet" "public" {
  cidr_block        = var.cidr_block_subnet_public
  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zone

    tags = {
    Name = "Public subnet"
  }
}

resource "aws_subnet" "private" {
  cidr_block        = var.cidr_block_subnet_private
  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zone

    tags = {
    Name = "Private subnet"
  }
}