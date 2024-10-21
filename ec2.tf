data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter{
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
  
}

resource "aws_instance" "private" {
  count                       = length(aws_subnet.private)
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  vpc_security_group_ids      = ["${aws_security_group.main.id}"]
  associate_public_ip_address = false
  
  subnet_id                   = element(aws_subnet.private[*].id, count.index)

  tags = {
    Name = "SSH-${count.index + 1}"
  }
}