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

resource "aws_instance" "this" {
  count                       = var.counter
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  vpc_security_group_ids          = ["${aws_security_group.this.id}"]
  associate_public_ip_address = true

  subnet_id = aws_subnet.public.id

  tags = {
    Name = "SSH-${count.index + 1}"
  }
}