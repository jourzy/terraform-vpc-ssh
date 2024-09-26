# Terraform AWS VPC and EC2 Setup

This Terraform configuration creates an AWS Virtual Private Cloud (VPC) environment with essential resources, including a VPC, Subnet, Internet Gateway, Route Table, Security Group, and EC2 instances running Ubuntu. The environment is designed to allow secure SSH access and all outbound traffic.


## Prerequisites

Before running the Terraform configuration, ensure you have the following installed:

- AWS Account: Ensure you have an AWS account with appropriate IAM permissions for creating VPC, EC2, and other networking resources.
- Terraform: Install Terraform v1.2 or higher. Instructions can be found [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
- AWS CLI: Make sure your AWS credentials are configured locally (e.g., using aws configure).
- Git


## Usage

**1. Clone the repository**

```git clone https://github.com/jourzy/terraform-vpc-ssh.git```

```cd terraform-vpc-ssh```

**2. Configure AWS credentials**

Ensure that your AWS credentials are properly configured either through environment variables or by using the AWS CLI:

```aws configure```

This will prompt you to enter your AWS Access Key, Secret Key, and the default region (set to eu-west-2 in this example).

**3. Initialize the Terraform working directory**

Initialize Terraform to download the required providers:

```terraform init```

**4. Preview the infrastructure changes**

You can preview the resources by running:

```terraform plan```

**5. Apply the configuration**

Deploy the resources in AWS using Terraform:

```terraform apply```

You will be asked to enter a value for var.cidr_block_ingress.
Enter the public IP address for the device you are using using CIDR block notation. It should be enclosed in quotation marks and square brackets. E.g. ```["181.23.51.142/32"]``` where 181.23.51.142 is your ip address.

Type ```yes``` when prompted to confirm the changes.

**6. Verify the infrastructure**

Once the infrastructure is launched, you can verify the resources in the AWS Management Console under EC2 in the eu-west-2 (London) region. 

**6. Destroy the infrastructure**

To clean up and remove the resources, run:

```terraform destroy```

Confirm with ```yes``` when prompted.


## Notes

- Update the public IP in the security group (security.tf line 12) to your current IP.
- Ensure your SSH key pair name is set correctly to enable SSH access to the EC2 instances (variables.tf - variable "key_pair_name").


## Resources created

**1. VPC (```aws_vpc```)**
- Creates a VPC with a CIDR block specified by the variable cidr_block.
- DNS hostnames and support are enabled.

**2. Subnet (```aws_subnet```)**
- Creates a subnet within the specified VPC.
- CIDR block is calculated from the VPC's CIDR using the cidrsubnet function.

**3. Internet gateway (```aws_internet_gateway```)**
- Attaches an Internet Gateway to the VPC, enabling internet connectivity.

**4. Route table (```aws_route_table```)**
- Creates a route table with a default route (0.0.0.0/0) that directs traffic to the Internet Gateway.

**5. Route table association (```aws_route_table_association```)**
- Associates the route table with the subnet to ensure the subnet has internet access.

**6. Security group (```aws_security_group```)**
- Allows inbound SSH access (TCP port 22) only from a specific IP address (185.240.198.113/32), representing your public IP.
- Allows all outbound traffic.

**7. Amazon machine image AMI (```data.aws.ami```)**
- Retrieves the latest Ubuntu 20.04 LTS AMI for use in EC2 instances.

**8. EC2 instance (```aws_instance```)**

- Creates one or more EC2 instances (based on var.counter) using the specified AMI and instance type.
- Associates each instance with the created subnet and security group.
- Public IP addresses are assigned to the instances.


This Terraform configuration provides a simple yet flexible environment for launching EC2 instances with SSH access and internet connectivity in a secure and customizable AWS VPC.


## Variables

The following input variables are provided with default values. These can be overridden during Terraform execution if needed:

|Variable|	Description|	Type|	Default Value|
|----------|----------|----------|----------|
|```key_pair_name```|	Name of the SSH key pair to associate with the EC2 instance.|	string|	```public```|
|```instance_type```	|The type of EC2 instance to launch.	|string	|```t2.micro```|
|```instance_tag```	|Tag assigned to each deployed EC2 instance.	|string	|```instance```|
|```counter```	|Number of EC2 instances to launch.	|number	|```1```|
|```file_name```	|Name of the SSH key pair file.	|string	|```public.pem```|
|```cidr_block```	|The CIDR block for the VPC.	|string	|```10.0.0.0/16```|
|```availability_zone```	|AWS Availability Zone for the subnet.	|string	|```eu-west-2a```|

You can override these variables in the variables.tf file or by passing them directly when executing Terraform commands (e.g. ```terraform apply -var "instance_type=t3.micro"```).


## Outputs

The following output is provided by this Terraform configuration:

|Output	|Description	|Value|
|----------|----------|----------|
|```instance_ip```	|The public IP addresses for SSH access to the EC2 instances.	|```aws_instance.this[*].public_ip```|

This output will display the public IP addresses of all EC2 instances once the infrastructure is deployed, allowing you to connect via SSH.


## To connect to your instance using an SSH client

1. Open a terminal window on your computer.
2. Use the ssh command to connect to the instance. You need the following details about your instance:
- the location of the private key (.pem file)
- the username (Ubuntu)
- the public IP4 address as provided as an output. 

The following are example commands.

```ssh -i /path/key-pair-name.pem ubuntu@instance-public-IP-address```

You can find more information about this process [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-linux-inst-ssh.html).

For troubleshooting, go to [this link](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html).


## License

This project is licensed under the MIT License. See the [LICENSE](https://opensource.org/license/MIT) file for details.



Feel free to contribute or raise issues in the repository to improve the project!
