
resource "aws_route_table" "second" {
 vpc_id = aws_vpc.this.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.this.id
 }
 
 tags = {
   Name = "2nd Route Table"
 }
}