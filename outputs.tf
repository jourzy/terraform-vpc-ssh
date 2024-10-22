# output "instance_public_ips" {
#   description = "The public ip addresses of the EC2 instances for ssh access"
#   // Maps the instance ids to their public ips
#   value       = {for instance in aws_instance.public : instance.id => instance.public_ip}
# }


output "public_subnet_ids" {
  description = "The ids of the public subnets to assign to EC2s"
  # Gets the ids of all the aws_subnet resources that have the name public
  value       = aws_subnet.public[*].id
}


output "bastion_public_ip" {
  description = "The public ip address of the bastion host"
  value       = aws_instance.bastion.public_ip
}
