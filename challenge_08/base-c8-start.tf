# DSEC AWS Workshop
# NETWORKIING

# ================================================================================
# 1. VARIABLES
# ================================================================================

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}
variable "ami" {}
variable "instance_type" {}


# Network:
variable "network_address_space" {
  default = "10.1.0.0/16"
}

# Subnet 1
variable "subnet1_address_space" {
  default = "10.1.1.0/24"
}

# Subnet 2
variable "subnet2_address_space" {
  default = "10.1.2.0/24"
}


# ================================================================================
# 2. PROVIDERS
# ================================================================================

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-west-1"
}

# ================================================================================
# 3. DATA
# ================================================================================

data "aws_availability_zones" "available" {}


# ================================================================================
# 3. RESOURCES
# ================================================================================

# Networking
resource "aws_vpc" "DSEC-VPC" {
  cidr_block = "${var.network_address_space}"
  enable_dns_hostnames = "true"

  tags {
    Name = "DSEC-VPC"
  }
}

resource "aws_internet_gateway" "DSEC-IGW" {
  vpc_id = "${aws_vpc.DSEC-VPC.id}"

  tags {
    Name = "DSEC-IGW"
  }
}

resource "aws_subnet" "DSEC-SUBNET1" {
  cidr_block = "${var.subnet1_address_space}"
  vpc_id = "${aws_vpc.DSEC-VPC.id}"
  map_public_ip_on_launch = "true"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "DSEC-SUBNET1"
  }
}

resource "aws_subnet" "DSEC-SUBNET2" {
  cidr_block = "${var.subnet2_address_space}"
  vpc_id = "${aws_vpc.DSEC-VPC.id}"
  map_public_ip_on_launch = "true"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "DSEC-SUBNET2"
  }
}

# Routing
resource "aws_route_table" "DSEC-RTB" {
  vpc_id = "${aws_vpc.DSEC-VPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.DSEC-IGW.id}"
  }

  tags {
    Name = "DSEC-RTB"
  }
}

resource "aws_route_table_association" "RTA-Subnet1" {
  route_table_id = "${aws_route_table.DSEC-RTB.id}"
  subnet_id = "${aws_subnet.DSEC-SUBNET1.id}"
}

resource "aws_route_table_association" "RTA-Subnet2" {
  route_table_id = "${aws_route_table.DSEC-RTB.id}"
  subnet_id = "${aws_subnet.DSEC-SUBNET2.id}"
}

# Security Groups
# Web Server Security Group
resource "aws_security_group" "WEBSRV-SG" {
  name = "websrv_sg"
  vpc_id = "${aws_vpc.DSEC-VPC.id}"

  tags {
    Name = "DSEC-WEBSRV-SG"
  }

  # ssh access
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  # http
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# EC2 Instance
resource "aws_instance" "WEBSRV" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id = "${aws_subnet.DSEC-SUBNET1.id}"
  vpc_security_group_ids = ["${aws_security_group.WEBSRV-SG.id}"]
  key_name = "${var.key_name}"

  tags {
    Name = "DSEC-WEBSRV-1"
    Team = "QA"
  }

  connection {
    user = "ec2-user"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "sudo service nginx start",
      "echo '<html><head><title>WEBSRV1</title></head><body>DSEC Meetup - WEBSERVER 1</body></html>' | sudo tee /usr/share/nginx/html/index.html"
    ]
  }
}


# ================================================================================
# 4. OUTPUT
# ================================================================================

output "aws_instance_public_dns" {
  value = "${aws_instance.WEBSRV.public_dns}"
}

output "aws_instance_public_ip" {
  value = "${aws_instance.WEBSRV.public_ip}"
}
