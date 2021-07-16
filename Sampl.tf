# CTRL + A --- select all text
# CTRL + / --- comment /uncomment 

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

 
}

provider "aws" {
 region  = "us-east-1"
 profile = "default"
}

resource "aws_instance" "my_app_server" {
 ami           = "ami-0d5eff06f840b45e9"
 instance_type = "t2.micro"

 tags = {
   Name = "myinstance"
 }
}

# # 1-Create a VPC
# resource "aws_vpc" "Production" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#   Name = "Pro_vpc"
# }
# }

# #2- Create Internet gateway
# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.Production.id
# }

# #3- Create custome Route table

# resource "aws_route_table" "prod-route-table" {
#   vpc_id =  aws_vpc.Production.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }

#   tags = {
#     Name = "Prod"
#   }
# }

# #4- Create a subnet

# resource "aws_subnet" "subnet1" {
#   vpc_id     = aws_vpc.Production.id
#   cidr_block = "10.0.1.0/24"
#   availability_zone = "us-east-1a"
# tags = {
#   Name = "prod_subnet"
# }
# }

# #5- Associate subnet with route table

# resource "aws_route_table_association" "a" {
#   subnet_id      = aws_subnet.subnet1.id
#   route_table_id = aws_route_table.prod-route-table.id
# }

# #6- security Group

# resource "aws_security_group" "allow_web" {
#   name        = "allow_tls"
#   description = "Allow web inbound traffic"
#   vpc_id      = aws_vpc.Production.id

#   ingress {
#     description      = "HTTPS"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
    
#   }

#   ingress {
#     description      = "SSH"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }
# }

# #7 Create Network interface

# resource "aws_network_interface" "test" {
#   subnet_id       = aws_subnet.subnet1.id
#   private_ips     = ["10.0.1.51"]
#   security_groups = [aws_security_group.allow_web.id]
# }

# #8- Create Elastic IP

# resource "aws_eip" "one" {
#   vpc                       = true
#   network_interface         = aws_network_interface.test.id
#   associate_with_private_ip = "10.0.1.51"
#   depends_on = [aws_internet_gateway.gw]
# }

# #9- Create instance 
# resource "aws_instance" "my_app_server" {
#   ami           = "ami-0ab4d1e9cf9a1215a"
#  instance_type = "t2.micro"
#  availability_zone = "us-east-1a"
#  key_name = "test1"
#  network_interface {
#    device_index = 0
#    network_interface_id = aws_network_interface.test.id
#  }
#  user_data = <<-EOF
#               #!/bin/bash
#               sudo yum update -y
#               sudo yum install httpd -y
#               sudo systemctl start httpd
#               sudo bash -c ' echo your first web server > /var/www/html/index
#               EOF
#   tags = {
#     Name = "Webserver"
#   }
#   }
