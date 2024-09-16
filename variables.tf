// default     = "ssh_key_pair"
variable "key_pair_name" {
  description = "key_pair_name"
  type        = string
  default     = "ssh_key_pair"
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

// default     = 1
variable "counter" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

// default     = "public.pem"
variable "file_name" {
  description = "Name of the key pair"
  type        = string
  default     = "public.pem"
}

// default       = "10.0.0.0/16"
variable "cidr_block" {
  description = "CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

// eu-west-2a
variable "availability_zone"{
  description = "Availability Zones for the Subnet"
  type        = string
  default     = "eu-west-2a"
}