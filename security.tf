resource "aws_security_group" "main" {
  name        = "SSH"
  description = "Security group allowing SSH and all egress traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    // replace variable with your own public ip address
    cidr_blocks = var.cidr_block_ingress
  }

  

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # semantically equivalent to all ports
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}



# Alternative to using ingress and egress arguments of the aws_security_group resource
# As reccommended here: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv4         = aws_vpc.main.cidr_block
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }

