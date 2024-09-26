
resource "aws_route_table" "second" {
 vpc_id = aws_vpc.this.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.this.id
 }
 
 tags = {
   Name = "SSH_2nd"
 }
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.second.id
}