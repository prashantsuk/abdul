
# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
  }
}

# Create an internet gateway and attach it to the VPC
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyIGW"
  }
}

# Create a subnet within the VPC
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  map_public_ip_on_launch = true

  tags = {
    Name = "MySubnet"
  }
}

# Create a security group allowing incoming traffic on po
resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MySecurityGroup"
    
  }
}

# Create an EC2 instance within the subnet, and associate
resource "aws_instance" "my_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id              = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  key_name = var.key_name # Specify your key name here 

  tags = {
    Name = "MyEC2Instance"
  }
}
