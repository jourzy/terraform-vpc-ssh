// public.pem
variable "key_pair_name" {
  description = "key_pair_name"
  type        = string
}

// default     = "t2.micro"
variable "instance_type" {
  description = "Type of EC2 instance to provision"
  type        = string
  default     = "t2.micro"
}

variable "instance_tag" {
  description = "Tag given to each deployed Instance"
  type = string 
}


variable "counter" {
  description = "Number of instances to launch"
  type        = number
}

variable "file_name" {
  description = "Name of the key pair"
  type        = string
}

// default       = "10.0.0.0/16"
variable "cidr_block" {
  description = "CIDR Block"
  type = string
}

// eu-west-2a
variable "availability_zone"{
  description = "Availability Zones for the Subnet"
  type = string
}