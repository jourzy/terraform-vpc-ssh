resource "aws_subnet" "this" {
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 3, 1)
  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zone

    tags = {
    Name = "SSH"
  }
}