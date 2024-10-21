resource "aws_internet_gateway" "main" {
vpc_id = aws_vpc.main.id

 tags = {
   Name = "SSH"
 }
}


// NAT Gateways must be placed in public subnets to allow private instances to access the internet for updates, 
// while still not being directly accessible from the internet.
resource "aws_nat_gateway" "nat" {
  count         = length(aws_subnet.public)

  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.public[*].id, count.index)  # Place the NAT gateway in the public subnets
}

// Allocate an Elastic IP (EIP) for the NAT gateway
resource "aws_eip" "nat" {
  vpc = true
}
